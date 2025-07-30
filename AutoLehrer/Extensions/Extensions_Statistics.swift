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
        if let theStatistics = get_statistics(nomen){
            theStatistics.score += 1
            theStatistics.lastAttempt = Date.now
        }else{
            let newStatistics = Statistics(context: context)
            newStatistics.relNomen = nomen
            newStatistics.score = 1
            
        }
    }
    public static func set_failure(_ nomen: Nomen){
        guard let context = nomen.managedObjectContext else {
            return
        }
        if let theStatistics = get_statistics(nomen){
            theStatistics.score = 0
            theStatistics.lastAttempt = Date.now
        }else{
            let newStatistics = Statistics(context: context)
            newStatistics.relNomen = nomen
            newStatistics.score = 0
            
        }
    }
    public static func set_default(_ nomen: Nomen){
        guard let context = nomen.managedObjectContext else {
            return
        }
        if let theStatistics = get_statistics(nomen){
            theStatistics.score = 0
            theStatistics.lastAttempt = Date.now
        }else{
            let newStatistics = Statistics(context: context)
            newStatistics.relNomen = nomen
            newStatistics.score = 0
            
        }
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
        let allTheNomenHives = try! context.fetch(NomenHive.fetchRequest())
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
        let allTheFormsOfNomen = nomenHive.relNomen?.allObjects as? [Nomen] ?? []
        let nomenHiveUrgencyMultiplier = Float(1 / nomenHive.nomenFrequencyOrder)
        let allTheFormUrgencies: [Float] = allTheFormsOfNomen.map{Statistics.nomenFormScore($0)}
        let maxFormUrgency = Float.maxFromArray(values: allTheFormUrgencies)
        return nomenHiveUrgencyMultiplier*maxFormUrgency
    }
    public static func nomenFormScore(_ nomen: Nomen) -> Float{
        guard let statisticsForNomen: Statistics = Statistics.get_statistics(nomen) else {
            Statistics.set_default(nomen)
            return log(1.0 + Float(Date.get_offset_inDays(Date.distantPast, Date.now)))
        }
        return (1.0/(1.0 + Float(statisticsForNomen.score)))*log(1.0 + Float(Date.get_offset_inDays(statisticsForNomen.lastAttempt ?? Date.distantPast, Date.now)))
    }
}
