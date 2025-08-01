//
//  Extensions_Statistics.swift
//  AutoLehrer
//
//  Created by Алексей Хурсевич on 29.07.25.
//

import CoreData

extension Statistics{
    public static func get_wort_total(_ context: NSManagedObjectContext, wortArt: WortArt?) -> Int{
        let all = try! context.fetch(WortHive.fetchRequest())
        return all.count
    }
    public static func get_wort_attempted(_ context: NSManagedObjectContext) -> Int{
        let all = try! context.fetch(WortHive.fetchRequest()).filter{$0.attempted}
        return all.count
    }
    public static func get_wort_confirmed(_ context: NSManagedObjectContext) -> Int{
        let all = try! context.fetch(WortHive.fetchRequest()).filter{$0.successCounter > 2}
        return all.count
    }
    public static func set_success(_ wort: Wort){
        guard let context = wort.managedObjectContext else {
            return
        }
        wort.relWortHive!.coolDown = 20
        wort.relWortHive!.failed = false
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
        wort.relWortHive!.coolDown = 20
        wort.relWortHive!.failed = true
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
    public static func pickNomenHive(_ context: NSManagedObjectContext) -> WortHive{
        NomenHive.coolDown(context)
        let coolFailed = WortHive.get_failedCool(context)
        if(coolFailed.count > 0){
            return pickFromRange(coolFailed)
        }
        let coolSuccessfulTop = WortHive.get_successfulCoolTop(context)
        if(coolSuccessfulTop.count > 0){
            return pickFromRange(coolSuccessfulTop)
        }
        let coolSuccessfulRest = WortHive.get_successfulCoolRest(context)
        if(coolSuccessfulRest.count > 0){
            return pickFromRange(coolSuccessfulRest)
        }
        let hotFailed = WortHive.get_failedHot(context)
        if(hotFailed.count > 0){
            return pickFromRange(hotFailed)
        }
        let hotSuccessful = WortHive.get_successfulHot(context)
        return pickFromRange(hotSuccessful)
    }
    public static func pickFromRange(_ allTheNomenHives: [WortHive]) -> WortHive{
        var retValue = allTheNomenHives.first!
        var retScore = nomenHiveUrgency(retValue)
        print("Statistics.pickNomenHive: SET urgency \(retScore) for return \(retValue.nomenFrequencyOrder)")
        for theCounter in 1..<allTheNomenHives.count{
            let theUrgency = nomenHiveUrgency(allTheNomenHives[theCounter])
            print("Statistics.pickNomenHive: urgency \(theUrgency) for \(allTheNomenHives[theCounter].nomenFrequencyOrder)")
            if theUrgency > retScore{
                retValue = allTheNomenHives[theCounter]
                retScore = theUrgency
                print("Statistics.pickNomenHive: SET urgency \(retScore) for return \(retValue.nomenFrequencyOrder)")
            }
        }
        return retValue
    }
    public static func nomenHiveUrgency(_ wortHive: WortHive) -> Float{
        //print("   Statistics.nomenHiveUrgency: \(nomenHive.nomenFrequencyOrder)")
        let allTheFormsOfWort = wortHive.relWort?.allObjects as? [Wort] ?? []
        let nomenHiveUrgencyMultiplier = Float(1.0 / Float(nomenHive.wortFrequencyOrder))
        //print("   Statistics.nomenHiveUrgency: frequency order: \(nomenHive.nomenFrequencyOrder)")
        print("   Statistics.nomenHiveUrgency: urgency multiplier: \(Float(1.0 / Float(WortHive.wortFrequencyOrder)))")
        let allTheFormUrgencies: [Float] = allTheFormsOfNomen.map{Statistics.nomenFormScore($0)}
        let maxFormUrgency = Float.maxFromArray(values: allTheFormUrgencies)
        //print("   Statistics.nomenHiveUrgency: max urgency: \(maxFormUrgency)")
        return nomenHiveUrgencyMultiplier*maxFormUrgency
    }
    public static func nomenFormScore(_ wort: Wort) -> Float{
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
