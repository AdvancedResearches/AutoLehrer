//
//  Extensions_Statistics.swift
//  AutoLehrer
//
//  Created by Алексей Хурсевич on 29.07.25.
//

import CoreData

extension Statistics{
    public static func set_success(_ nomen: Nomen){
        guard let context = nomen.managedObjectContext else {
            return
        }
        nomen.relNomenHive!.coolDown = 20
        nomen.relNomenHive!.failed = false
        if let theStatistics = get_statistics(nomen){
            theStatistics.score += 1
            theStatistics.lastAttempt = Date.now
        }else{
            let newStatistics = Statistics(context: context)
            newStatistics.relNomen = nomen
            newStatistics.score = 1
            newStatistics.lastAttempt = Date.now
        }
        do{
            try context.save()
        }catch{}
    }
    public static func set_failure(_ nomen: Nomen){
        guard let context = nomen.managedObjectContext else {
            return
        }
        nomen.relNomenHive!.coolDown = 20
        nomen.relNomenHive!.failed = true
        if let theStatistics = get_statistics(nomen){
            theStatistics.score = min(0, theStatistics.score - 1)
            theStatistics.lastAttempt = Date.now
        }else{
            let newStatistics = Statistics(context: context)
            newStatistics.relNomen = nomen
            newStatistics.score = 0
            newStatistics.lastAttempt = Date.now
        }
        do{
            try context.save()
        }catch{}
    }
    public static func set_default(_ nomen: Nomen){
        guard let context = nomen.managedObjectContext else {
            return
        }
        if let theStatistics = get_statistics(nomen){
            theStatistics.score = 0
            theStatistics.lastAttempt = Date.distantPast
        }else{
            let newStatistics = Statistics(context: context)
            newStatistics.relNomen = nomen
            newStatistics.score = 0
            newStatistics.lastAttempt = Date.distantPast
        }
        do{
            try context.save()
        }catch{}
    }
    public static func get_statistics(_ nomen: Nomen) -> Statistics?{
        guard let context = nomen.managedObjectContext else {
            return nil
        }
        do{
            let theStatistics = try context.fetch(Statistics.fetchRequest()).filter{$0.relNomen == nomen}
            return theStatistics.first
        }catch{
        }
        return nil
    }
    public static func pickNomenHive(_ context: NSManagedObjectContext) -> NomenHive{
        NomenHive.coolDown(context)
        let coolFailed = NomenHive.get_failedCool(context)
        if(coolFailed.count > 0){
            return pickFromRange(coolFailed)
        }
        let coolSuccessful = NomenHive.get_successfulCool(context)
        if(coolSuccessful.count > 0){
            return pickFromRange(coolSuccessful)
        }
        let hotFailed = NomenHive.get_failedHot(context)
        if(hotFailed.count > 0){
            return pickFromRange(hotFailed)
        }
        let hotSuccessful = NomenHive.get_successfulHot(context)
        return pickFromRange(hotSuccessful)
        /*
        let allTheNomenHives = try! context.fetch(NomenHive.fetchRequest()).sorted{$0.nomenFrequencyOrder < $1.nomenFrequencyOrder}
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
         */
    }
    public static func pickFromRange(_ allTheNomenHives: [NomenHive]) -> NomenHive{
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
    public static func nomenHiveUrgency(_ nomenHive: NomenHive) -> Float{
        //print("   Statistics.nomenHiveUrgency: \(nomenHive.nomenFrequencyOrder)")
        let allTheFormsOfNomen = nomenHive.relNomen?.allObjects as? [Nomen] ?? []
        let nomenHiveUrgencyMultiplier = Float(1.0 / Float(nomenHive.nomenFrequencyOrder))
        //print("   Statistics.nomenHiveUrgency: frequency order: \(nomenHive.nomenFrequencyOrder)")
        print("   Statistics.nomenHiveUrgency: urgency multiplier: \(Float(1.0 / Float(nomenHive.nomenFrequencyOrder)))")
        let allTheFormUrgencies: [Float] = allTheFormsOfNomen.map{Statistics.nomenFormScore($0)}
        let maxFormUrgency = Float.maxFromArray(values: allTheFormUrgencies)
        //print("   Statistics.nomenHiveUrgency: max urgency: \(maxFormUrgency)")
        return nomenHiveUrgencyMultiplier*maxFormUrgency
    }
    public static func nomenFormScore(_ nomen: Nomen) -> Float{
        print("      Statistics.nomenFormScore: \(nomen.nomen_RU!)-\(nomen.nomen_DE!)")
        guard let statisticsForNomen: Statistics = Statistics.get_statistics(nomen) else {
            //print("      Statistics.nomenFormScore: NOT FOUND, SET DEFAULT")
            Statistics.set_default(nomen)
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
