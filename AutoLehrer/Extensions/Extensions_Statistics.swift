//
//  Extensions_Statistics.swift
//  AutoLehrer
//
//  Created by Алексей Хурсевич on 29.07.25.
//

import CoreData

extension Statistics{
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
        for theCounter in 1..<allTheNomenHives.count{
            let theUrgency = nomenHiveUrgency(allTheNomenHives[theCounter])
            if theUrgency < retScore{
                retValue = allTheNomenHives[theCounter]
                retScore = theUrgency
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
            return 0
        }
        return (1.0/(1.0 + Float(statisticsForNomen.score)))*log(1.0 + Float(Date.get_offset_inDays(statisticsForNomen.lastAttempt ?? Date.distantPast, Date.now)))
    }
}
