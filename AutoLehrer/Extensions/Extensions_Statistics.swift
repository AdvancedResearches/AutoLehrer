//
//  Extensions_Statistics.swift
//  AutoLehrer
//
//  Created by Алексей Хурсевич on 29.07.25.
//

import CoreData

extension Statistics{
    public static func get_wort_total_atAll(_ context: NSManagedObjectContext) -> Int{
        let allArten = WortArt.get_alleWortArten(context)
        var retValue: Int = 0
        for theArt in allArten{
            retValue += get_wort_total_byWortArt(context, theArt)
        }
        return retValue
    }
    public static func get_wort_attempted_atAll(_ context: NSManagedObjectContext) -> Int{
        let allArten = WortArt.get_alleWortArten(context)
        var retValue: Int = 0
        for theArt in allArten{
            retValue += get_wort_attempted_byWortArt(context, theArt)
        }
        return retValue
    }
    public static func get_wort_confirmed_atAll(_ context: NSManagedObjectContext) -> Int{
        let allArten = WortArt.get_alleWortArten(context)
        var retValue: Int = 0
        for theArt in allArten{
            retValue += get_wort_confirmed_byWortArt(context, theArt)
        }
        return retValue
    }
    public static func get_wort_total_byWortArt(_ context: NSManagedObjectContext, _ wortArt: WortArt?) -> Int{
        let all = try! context.fetch(WortFormen.fetchRequest())
        if(wortArt != nil){
            return all.filter{$0.relWortArt == wortArt}.count
        }
        return all.count
    }
    public static func get_wort_attempted_byWortArt(_ context: NSManagedObjectContext, _ wortArt: WortArt?) -> Int{
        let all = try! context.fetch(WortFormen.fetchRequest()).filter{$0.attempted}
        if(wortArt != nil){
            return all.filter{$0.relWortArt == wortArt}.count
        }
        return all.count
    }
    public static func get_wort_confirmed_byWortArt(_ context: NSManagedObjectContext, _ wortArt: WortArt?) -> Int{
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
    public static func pickWortFormen_2(_ wortArt: WortArt) -> WortFormen{
        let context = wortArt.managedObjectContext!
        
        let requestAllInWorkReadyAndNotFailed: NSFetchRequest<WortFormen> = WortFormen.fetchRequest()
        requestAllInWorkReadyAndNotFailed.predicate = NSPredicate(
            format: "relWortArt == %@ AND state != %@ AND failCounter == 0 AND (nextPlanedAttempt == nil OR nextPlanedAttempt <= %@)",
            wortArt,
            "never",
            Date() as CVarArg
        )
        requestAllInWorkReadyAndNotFailed.sortDescriptors = [
            NSSortDescriptor(key: "nextPlanedAttempt", ascending: true)
        ]
        
        let requestAllInWorkReadyAndFailed: NSFetchRequest<WortFormen> = WortFormen.fetchRequest()
        requestAllInWorkReadyAndFailed.predicate = NSPredicate(
            format: "relWortArt == %@ AND state != %@ AND failCounter > 0 AND (nextPlanedAttempt == nil OR nextPlanedAttempt <= %@)",
            wortArt,
            "never",
            Date() as CVarArg
        )
        requestAllInWorkReadyAndFailed.sortDescriptors = [
            NSSortDescriptor(key: "nextPlanedAttempt", ascending: true)
        ]
        
        let requestAllNotInWork: NSFetchRequest<WortFormen> = WortFormen.fetchRequest()
        requestAllNotInWork.predicate = NSPredicate(
            format: "relWortArt == %@ AND state == %@",
            wortArt,
            "never",
            Date() as CVarArg
        )
        requestAllNotInWork.sortDescriptors = [
            NSSortDescriptor(key: "nextPlanedAttempt", ascending: true)
        ]
        
        let requestAllInWorkNotReady: NSFetchRequest<WortFormen> = WortFormen.fetchRequest()
        requestAllInWorkNotReady.predicate = NSPredicate(
            format: "relWortArt == %@ AND state != %@ AND (nextPlanedAttempt != nil AND nextPlanedAttempt > %@)",
            wortArt,
            "never",
            Date() as CVarArg
        )
        requestAllInWorkNotReady.sortDescriptors = [
            NSSortDescriptor(key: "nextPlanedAttempt", ascending: true)
        ]
        
        let requestAllInWorkNotReadyAndNotFailed: NSFetchRequest<WortFormen> = WortFormen.fetchRequest()
        requestAllInWorkNotReadyAndNotFailed.predicate = NSPredicate(
            format: "relWortArt == %@ AND state != %@ AND failCounter == 0 AND (nextPlanedAttempt != nil AND nextPlanedAttempt > %@)",
            wortArt,
            "never",
            Date() as CVarArg
        )
        requestAllInWorkNotReadyAndNotFailed.sortDescriptors = [
            NSSortDescriptor(key: "nextPlanedAttempt", ascending: true)
        ]
        
        let requestAllInWorkNotReadyAndFailed: NSFetchRequest<WortFormen> = WortFormen.fetchRequest()
        requestAllInWorkNotReadyAndFailed.predicate = NSPredicate(
            format: "relWortArt == %@ AND state != %@ AND failCounter > 0 AND (nextPlanedAttempt != nil AND nextPlanedAttempt > %@)",
            wortArt,
            "never",
            Date() as CVarArg
        )
        requestAllInWorkNotReadyAndFailed.sortDescriptors = [
            NSSortDescriptor(key: "nextPlanedAttempt", ascending: true)
        ]
        
        let allInWorkReadyAndNotFailed = try! context.fetch(requestAllInWorkReadyAndNotFailed)
        let allInWorkReadyAndFailed = try! context.fetch(requestAllInWorkReadyAndFailed)
        let allNotInWork = try! context.fetch(requestAllNotInWork)
        let allInWorkNotReady = try! context.fetch(requestAllInWorkNotReady)
        let allInWorkNotReadyAndNotFailed = try! context.fetch(requestAllInWorkNotReadyAndNotFailed)
        let allInWorkNotReadyAndFailed = try! context.fetch(requestAllInWorkNotReadyAndFailed)
        
        print("pickWortFormen_2: ReadyAndNotFailed \(allInWorkReadyAndNotFailed.count), ReadyAndFailed \(allInWorkReadyAndFailed.count), NeverTried \(allNotInWork.count), NotReady \(allInWorkNotReady.count) (\(allInWorkNotReadyAndNotFailed.count)/\(allInWorkNotReadyAndFailed.count)), IN TOTAL \(allInWorkReadyAndNotFailed.count + allInWorkReadyAndFailed.count + allNotInWork.count + allInWorkNotReady.count)")
        
        if let ersteReadyNotFailed = allInWorkReadyAndNotFailed.first {
            return ersteReadyNotFailed
        }
        if let ersteReadyFailed = allInWorkReadyAndFailed.first {
            return ersteReadyFailed
        }
        if let ersteNotInWork = allNotInWork.first {
            return ersteNotInWork
        }
        return allInWorkNotReady.first!
    }
    public static func pickWortFormen(_ context: NSManagedObjectContext, wortArt: WortArt) -> WortFormen{
        let startTime = Date().timeIntervalSince1970 * 1000
        WortFormen.coolDown(context, wortArt)
        
        let alleWortformen: [WortFormen] = wortArt.relWortFormen?.allObjects  as! [WortFormen] ?? []
        print("Statistics.pickWortFormen: for wortArt \(wortArt.name_DE!)")
        
        print("Statistics.pickWortFormen:       FAILED COOLED DOWN")
        for theWortForm in alleWortformen.filter{$0.failed && $0.coolDown == 0}.sorted{$0.wortFrequencyOrder < $1.wortFrequencyOrder}{
            print("Statistics.pickWortFormen:       wort form \(theWortForm.wortFrequencyOrder) with coolDown=\(theWortForm.coolDown), failed=\(theWortForm.failed), successCounter=\(theWortForm.successCounter), urgencyCache=\(theWortForm.urgencyCache)")
        }
        
        print("Statistics.pickWortFormen:       SUCCEEDED COOLED DOWN")
        for theWortForm in alleWortformen.filter{!$0.failed && $0.coolDown == 0}.sorted{$0.wortFrequencyOrder < $1.wortFrequencyOrder}{
            print("Statistics.pickWortFormen:       wort form \(theWortForm.wortFrequencyOrder) with coolDown=\(theWortForm.coolDown), failed=\(theWortForm.failed), successCounter=\(theWortForm.successCounter), urgencyCache=\(theWortForm.urgencyCache)")
        }
        
        print("Statistics.pickWortFormen:       FAILED HOT NOT RECENT 3")
        for theWortForm in alleWortformen.filter{$0.failed && $0.coolDown < (WortFormen.failCoolDown - 3)}.sorted{$0.wortFrequencyOrder < $1.wortFrequencyOrder}{
            print("Statistics.pickWortFormen:       wort form \(theWortForm.wortFrequencyOrder) with coolDown=\(theWortForm.coolDown), failed=\(theWortForm.failed), successCounter=\(theWortForm.successCounter), urgencyCache=\(theWortForm.urgencyCache)")
        }
        
        print("Statistics.pickWortFormen:       SUCCEEDED HOT NOT RECENT 3")
        for theWortForm in alleWortformen.filter{!$0.failed && $0.coolDown < (WortFormen.successCoolDown - 3)}.sorted{$0.wortFrequencyOrder < $1.wortFrequencyOrder}{
            print("Statistics.pickWortFormen:       wort form \(theWortForm.wortFrequencyOrder) with coolDown=\(theWortForm.coolDown), failed=\(theWortForm.failed), successCounter=\(theWortForm.successCounter), urgencyCache=\(theWortForm.urgencyCache)")
        }
        
        print("Statistics.pickWortFormen:       FAILED HOT RECENT 3")
        for theWortForm in alleWortformen.filter{$0.failed && $0.coolDown >= (WortFormen.failCoolDown - 3)}.sorted{$0.wortFrequencyOrder < $1.wortFrequencyOrder}{
            print("Statistics.pickWortFormen:       wort form \(theWortForm.wortFrequencyOrder) with coolDown=\(theWortForm.coolDown), failed=\(theWortForm.failed), successCounter=\(theWortForm.successCounter), urgencyCache=\(theWortForm.urgencyCache)")
        }
        
        print("Statistics.pickWortFormen:       SUCCEEDED HOT RECENT 3")
        for theWortForm in alleWortformen.filter{!$0.failed && $0.coolDown >= (WortFormen.successCoolDown - 3)}.sorted{$0.wortFrequencyOrder < $1.wortFrequencyOrder}{
            print("Statistics.pickWortFormen:       wort form \(theWortForm.wortFrequencyOrder) with coolDown=\(theWortForm.coolDown), failed=\(theWortForm.failed), successCounter=\(theWortForm.successCounter), urgencyCache=\(theWortForm.urgencyCache)")
        }
        
        let coolFailed = WortFormen.get_failedCool(context, wortArt)
        if(coolFailed.count > 0){
            let endTime = Date().timeIntervalSince1970 * 1000
            let diffMs = endTime - startTime
            print("Statistics.pickWortFormen: duration coolFailed \(diffMs) ms")
            let pickedWortFormen: WortFormen = pickFromRange(coolFailed)
            print("Statistics.pickWortFormen: picked wort form \(pickedWortFormen.wortFrequencyOrder) with coolDown=\(pickedWortFormen.coolDown), failed=\(pickedWortFormen.failed), successCounter=\(pickedWortFormen.successCounter), urgencyCache=\(pickedWortFormen.urgencyCache)")
            return pickedWortFormen
        }else{
            print("Statistics.pickWortFormen: nothing to pick from coolFailed")
        }
        let coolSuccessfulTop = WortFormen.get_successfulCoolTop(context, wortArt)
        if(coolSuccessfulTop.count > 0){
            let endTime = Date().timeIntervalSince1970 * 1000
            let diffMs = endTime - startTime
            print("Statistics.pickWortFormen: duration coolSuccessfulTop \(diffMs) ms")
            let pickedWortFormen: WortFormen = pickFromRange(coolSuccessfulTop)
            print("Statistics.pickWortFormen: picked wort form \(pickedWortFormen.wortFrequencyOrder) with coolDown=\(pickedWortFormen.coolDown), failed=\(pickedWortFormen.failed), successCounter=\(pickedWortFormen.successCounter), urgencyCache=\(pickedWortFormen.urgencyCache)")
            return pickedWortFormen
        }else{
            print("Statistics.pickWortFormen: nothing to pick from coolSuccessfulTop")
        }
        let coolSuccessfulRest = WortFormen.get_successfulCoolRest(context, wortArt)
        if(coolSuccessfulRest.count > 0){
            let endTime = Date().timeIntervalSince1970 * 1000
            let diffMs = endTime - startTime
            print("Statistics.pickWortFormen: duration coolSuccessfulRest \(diffMs) ms")
            let pickedWortFormen: WortFormen = pickFromRange(coolSuccessfulRest)
            print("Statistics.pickWortFormen: picked wort form \(pickedWortFormen.wortFrequencyOrder) with coolDown=\(pickedWortFormen.coolDown), failed=\(pickedWortFormen.failed), successCounter=\(pickedWortFormen.successCounter), urgencyCache=\(pickedWortFormen.urgencyCache)")
            return pickedWortFormen
        }else{
            print("Statistics.pickWortFormen: nothing to pick from coolSuccessfulRest")
        }
        let hotFailedNotRecent3 = WortFormen.get_failedHot_notRecent3(context, wortArt)
        if(hotFailedNotRecent3.count > 0){
            let endTime = Date().timeIntervalSince1970 * 1000
            let diffMs = endTime - startTime
            print("Statistics.pickWortFormen: duration hotFailedNotRecent3 \(diffMs) ms")
            let pickedWortFormen: WortFormen = pickFromRange(hotFailedNotRecent3)
            print("Statistics.pickWortFormen: picked wort form \(pickedWortFormen.wortFrequencyOrder) with coolDown=\(pickedWortFormen.coolDown), failed=\(pickedWortFormen.failed), successCounter=\(pickedWortFormen.successCounter), urgencyCache=\(pickedWortFormen.urgencyCache)")
            return pickedWortFormen
        }else{
            print("Statistics.pickWortFormen: nothing to pick from hotFailedNotRecent3")
        }
        let hotSuccessfulNotRecent3 = WortFormen.get_successfulHot_notRecent3(context, wortArt)
        if(hotSuccessfulNotRecent3.count > 0){
            let endTime = Date().timeIntervalSince1970 * 1000
            let diffMs = endTime - startTime
            print("Statistics.pickWortFormen: duration hotFailedNotRecent3 \(diffMs) ms")
            let pickedWortFormen: WortFormen = pickFromRange(hotSuccessfulNotRecent3)
            print("Statistics.pickWortFormen: picked wort form \(pickedWortFormen.wortFrequencyOrder) with coolDown=\(pickedWortFormen.coolDown), failed=\(pickedWortFormen.failed), successCounter=\(pickedWortFormen.successCounter), urgencyCache=\(pickedWortFormen.urgencyCache)")
            return pickedWortFormen
        }else{
            print("Statistics.pickWortFormen: nothing to pick from hotSuccessfulNotRecent3")
        }
        let hotFailedRecent3 = WortFormen.get_failedHot_recent3(context, wortArt)
        if(hotFailedRecent3.count > 0){
            let endTime = Date().timeIntervalSince1970 * 1000
            let diffMs = endTime - startTime
            print("Statistics.pickWortFormen: duration hotFailedRecent3 \(diffMs) ms")
            let pickedWortFormen: WortFormen = pickFromRange(hotFailedRecent3)
            print("Statistics.pickWortFormen: picked wort form \(pickedWortFormen.wortFrequencyOrder) with coolDown=\(pickedWortFormen.coolDown), failed=\(pickedWortFormen.failed), successCounter=\(pickedWortFormen.successCounter), urgencyCache=\(pickedWortFormen.urgencyCache)")
            return pickedWortFormen
        }else{
            print("Statistics.pickWortFormen: nothing to pick from hotFailedRecent3")
        }
        let hotSuccessfulRecent3 = WortFormen.get_successfulHot_recent3(context, wortArt)
        let endTime = Date().timeIntervalSince1970 * 1000
        let diffMs = endTime - startTime
        print("Statistics.pickWortFormen: duration hotSuccessfulRecent3 \(diffMs) ms")
        let pickedWortFormen: WortFormen = pickFromRange(hotSuccessfulRecent3)
        print("Statistics.pickWortFormen: picked wort form \(pickedWortFormen.wortFrequencyOrder) with coolDown=\(pickedWortFormen.coolDown), failed=\(pickedWortFormen.failed), successCounter=\(pickedWortFormen.successCounter), urgencyCache=\(pickedWortFormen.urgencyCache)")
        return pickedWortFormen
    }
    public static func pickFromRange(_ allTheWortFormen: [WortFormen]) -> WortFormen{
        var retValue = allTheWortFormen.first!
        var retScore = wortFormenUrgency(retValue)
        for theCounter in 1..<allTheWortFormen.count{
            let theUrgency = wortFormenUrgency(allTheWortFormen[theCounter])
            if theUrgency > retScore{
                retValue = allTheWortFormen[theCounter]
                retScore = theUrgency
            }
        }
        return retValue
    }
    public static func wortFormenUrgency(_ wortFormen: WortFormen) -> Float{
        let cachedUrgency = wortFormen.urgencyCache
        if(cachedUrgency == -10000){
            let allTheFormsFomWort = wortFormen.relWort?.allObjects as? [Wort] ?? []
            let wortFormenUrgencyMultiplier = Float(1.0 / Float(wortFormen.wortFrequencyOrder))
            print("   Statistics.wortFormenUrgency: urgency multiplier: \(Float(1.0 / Float(wortFormen.wortFrequencyOrder)))")
            let allTheFormenUrgencies: [Float] = allTheFormsFomWort.map{Statistics.wortFormScore($0)}
            let maxFormUrgency = Float.maxFromArray(values: allTheFormenUrgencies)
            let theUrgency = wortFormenUrgencyMultiplier*maxFormUrgency
            wortFormen.urgencyCache = theUrgency
            return theUrgency
        }else{
            return cachedUrgency
        }
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
