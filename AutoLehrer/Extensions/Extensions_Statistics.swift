//
//  Extensions_Statistics.swift
//  AutoLehrer
//
//  Created by Алексей Хурсевич on 29.07.25.
//

import CoreData

extension Statistics{
    public static func get_wort_total(_ context: NSManagedObjectContext, _ wortArt: WortArt?) -> Int{
        let all = try! context.fetch(WortFormen.fetchRequest())
        if(wortArt != nil){
            return all.filter{$0.relWortArt == wortArt}.count
        }
        return all.count
    }
    public static func get_wort_attempted(_ context: NSManagedObjectContext, _ wortArt: WortArt?) -> Int{
        let all = try! context.fetch(WortFormen.fetchRequest()).filter{$0.attempted}
        if(wortArt != nil){
            return all.filter{$0.relWortArt == wortArt}.count
        }
        return all.count
    }
    public static func get_wort_confirmed(_ context: NSManagedObjectContext, _ wortArt: WortArt?) -> Int{
        let all = try! context.fetch(WortFormen.fetchRequest()).filter{$0.successCounter > 2}
        if(wortArt != nil){
            return all.filter{$0.relWortArt == wortArt}.count
        }
        return all.count
    }
    public static func set_success(_ wort: Wort){
        guard let context = wort.managedObjectContext else {
            return
        }
        
        if let theStatistics = get_statistics(wort){
            theStatistics.score += 1
            theStatistics.lastAttempt = Date.now
        }else{
            let newStatistics = Statistics(context: context)
            newStatistics.relWort = wort
            newStatistics.score = 1
            newStatistics.lastAttempt = Date.now
        }
        do{
            try context.save()
        }catch{}
    }
    public static func set_failure(_ wort: Wort){
        guard let context = wort.managedObjectContext else {
            return
        }
        
        if let theStatistics = get_statistics(wort){
            theStatistics.score = min(0, theStatistics.score - 1)
            theStatistics.lastAttempt = Date.now
        }else{
            let newStatistics = Statistics(context: context)
            newStatistics.relWort = wort
            newStatistics.score = 0
            newStatistics.lastAttempt = Date.now
        }
        do{
            try context.save()
        }catch{}
    }
    public static func set_default(_ wort: Wort){
        guard let context = wort.managedObjectContext else {
            return
        }
        if let theStatistics = get_statistics(wort){
            theStatistics.score = 0
            theStatistics.lastAttempt = Date.distantPast
        }else{
            let newStatistics = Statistics(context: context)
            newStatistics.relWort = wort
            newStatistics.score = 0
            newStatistics.lastAttempt = Date.distantPast
        }
        do{
            try context.save()
        }catch{}
    }
    public static func get_statistics(_ wort: Wort) -> Statistics?{
        guard let context = wort.managedObjectContext else {
            return nil
        }
        do{
            let theStatistics = try context.fetch(Statistics.fetchRequest()).filter{$0.relWort == wort}
            return theStatistics.first
        }catch{
        }
        return nil
    }
    public static func pickWortFormen(_ context: NSManagedObjectContext, wortArt: WortArt) -> WortFormen{
        WortFormen.coolDown(context, wortArt)
        let coolFailed = WortFormen.get_failedCool(context, wortArt)
        if(coolFailed.count > 0){
            return pickFromRange(coolFailed)
        }
        let coolSuccessfulTop = WortFormen.get_successfulCoolTop(context, wortArt)
        if(coolSuccessfulTop.count > 0){
            return pickFromRange(coolSuccessfulTop)
        }
        let coolSuccessfulRest = WortFormen.get_successfulCoolRest(context, wortArt)
        if(coolSuccessfulRest.count > 0){
            return pickFromRange(coolSuccessfulRest)
        }
        let hotFailed = WortFormen.get_failedHot(context, wortArt)
        if(hotFailed.count > 0){
            return pickFromRange(hotFailed)
        }
        let hotSuccessful = WortFormen.get_successfulHot(context, wortArt)
        return pickFromRange(hotSuccessful)
    }
    public static func pickFromRange(_ allTheWortFormen: [WortFormen]) -> WortFormen{
        var retValue = allTheWortFormen.first!
        var retScore = wortFormenUrgency(retValue)
        print("Statistics.pickNomenHive: SET urgency \(retScore) for return \(retValue.wortFrequencyOrder)")
        for theCounter in 1..<allTheWortFormen.count{
            let theUrgency = wortFormenUrgency(allTheWortFormen[theCounter])
            print("Statistics.pickNomenHive: urgency \(theUrgency) for \(allTheWortFormen[theCounter].wortFrequencyOrder)")
            if theUrgency > retScore{
                retValue = allTheWortFormen[theCounter]
                retScore = theUrgency
                print("Statistics.pickNomenHive: SET urgency \(retScore) for return \(retValue.wortFrequencyOrder)")
            }
        }
        return retValue
    }
    public static func wortFormenUrgency(_ wortFormen: WortFormen) -> Float{
        //print("   Statistics.nomenHiveUrgency: \(nomenHive.nomenFrequencyOrder)")
        let allTheFormsOfWort = wortFormen.relWort?.allObjects as? [Wort] ?? []
        let wortFormenUrgencyMultiplier = Float(1.0 / Float(wortFormen.wortFrequencyOrder))
        //print("   Statistics.nomenHiveUrgency: frequency order: \(nomenHive.nomenFrequencyOrder)")
        print("   Statistics.wortFormenUrgency: urgency multiplier: \(Float(1.0 / Float(wortFormen.wortFrequencyOrder)))")
        let allTheFormenUrgencies: [Float] = allTheFormsOfWort.map{Statistics.wortFormScore($0)}
        let maxFormUrgency = Float.maxFromArray(values: allTheFormenUrgencies)
        //print("   Statistics.nomenHiveUrgency: max urgency: \(maxFormUrgency)")
        return wortFormenUrgencyMultiplier*maxFormUrgency
    }
    public static func wortFormScore(_ wort: Wort) -> Float{
        print("      Statistics.nomenFormScore: \(wort.wort_RU!)-\(wort.wort_DE!)")
        guard let statisticsForNomen: Statistics = Statistics.get_statistics(wort) else {
            //print("      Statistics.nomenFormScore: NOT FOUND, SET DEFAULT")
            Statistics.set_default(wort)
            let daysSinceLastAttempt = Date.get_offset_inDays(Date.distantPast, Date.now)
            let decay: Double = exp(0.0)
            let timeFactor: Double = log(1.0 + Double(daysSinceLastAttempt))
            print("      Statistics.nomenFormScore: NOT FOUND, SET DEFAULT")
            print("      Statistics.nomenFormScore: daysSinceLastAttempt = \(daysSinceLastAttempt)")
            print("      Statistics.nomenFormScore: score = 0")
            print("      Statistics.nomenFormScore: decay = \(decay)")
            print("      Statistics.nomenFormScore: timeFactor = \(timeFactor)")
            print("      Statistics.nomenFormScore: retValue = \(Float(decay*timeFactor))")
            return Float(decay*timeFactor)
        }
        //print("      Statistics.nomenFormScore: PICKED")
        let daysSinceLastAttempt = Date.get_offset_inDays(statisticsForNomen.lastAttempt ?? Date.distantPast, Date.now)
        let decay: Double = exp(Double(-statisticsForNomen.score))
        let timeFactor: Double = log(1.0 + Double(daysSinceLastAttempt))
        print("      Statistics.nomenFormScore: NOT FOUND, SET DEFAULT")
        print("      Statistics.nomenFormScore: daysSinceLastAttempt = \(daysSinceLastAttempt)")
        print("      Statistics.nomenFormScore: score = \(statisticsForNomen.score)")
        print("      Statistics.nomenFormScore: decay = \(decay)")
        print("      Statistics.nomenFormScore: timeFactor = \(timeFactor)")
        print("      Statistics.nomenFormScore: retValue = \(Float(decay*timeFactor))")
        return Float(decay*timeFactor)
    }
}
