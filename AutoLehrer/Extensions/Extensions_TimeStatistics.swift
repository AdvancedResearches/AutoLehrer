//
//  Extensions_TimeStatistics.swift
//  AutoLehrer
//
//  Created by Алексей Хурсевич on 30.08.25.
//

import CoreData

extension TimeStatistics{
    public static func auslesen_WieVieleMinutenHeute(_ context: NSManagedObjectContext) -> Int{
        guard let statsHeute: TimeStatistics? = auslesen_Statistics_amDate(in: context, at: Date.now.stripTime(), forThe: nil) else {
            return 0
        }
        return Int(statsHeute!.learningTime  / 60)
    }
    public static func auslesen_bereitFurPrufung(_ context: NSManagedObjectContext) -> Bool{
        let alleWortArten = try! context.fetch(WortArt.fetchRequest())
        var wortArtAcceptable: Int = 0
        for dieWortArt in alleWortArten{
            if(WortArt.fetch_alleConfirmedWorten(dieWortArt).count >= 10){
                wortArtAcceptable += 1
            }
        }
        return wortArtAcceptable > 0
    }
    public static func auslesen_daysSinceLastPrufung(_ context: NSManagedObjectContext) -> Int{
        let letztePrufung = Settings.getLetztePrufung(in: context)
        if(letztePrufung != nil){
            return Date.get_offset_inDays(letztePrufung!, Date.now)
        }
        return -1
    }
    public static func auslesen_hasAnnouncedAboveAverage(in context: NSManagedObjectContext, forThe wortArt: WortArt?){
        if let today = auslesen_Statistics_amDate(in: context, at: Date.now.stripTime(), forThe: wortArt){
            today.hasDeclaredSuperriorityVsAverage = true
            try! context.save()
        }
    }
    public static func auslesen_isAboveAverageToAnnounce(in context: NSManagedObjectContext, forThe wortArt: WortArt?) -> Bool{
        let today = auslesen_Statistics_amDate(in: context, at: Date.now.stripTime(), forThe: wortArt)
        if(today == nil){
            return false
        }
        if(today!.hasDeclaredSuperriorityVsAverage){
            return false
        }
        let average = auslesen_Statistics_wochenAverage(in: context, forThe: wortArt)
        if(average == nil){
            return false
        }
        let averageTime = auslesen_Statistics_wochenAverage(in: context, forThe: wortArt) ?? 0
        let todayTime = today!.learningTime
        if(todayTime > averageTime){
            return true
        }
        return false
    }
    public static func auslesen_hasAnnouncedAboveYesterday(in context: NSManagedObjectContext, forThe wortArt: WortArt?){
        if let today = auslesen_Statistics_amDate(in: context, at: Date.now.stripTime(), forThe: wortArt){
            today.hasDeclaredSuperriorityVsYesterday = true
            try! context.save()
        }
    }
    public static func auslesen_isAboveYesterdayToAnnounce(in context: NSManagedObjectContext, forThe wortArt: WortArt?) -> Bool{
        let today = auslesen_Statistics_amDate(in: context, at: Date.now.stripTime(), forThe: wortArt)
        if(today == nil){
            return false
        }
        if(today!.hasDeclaredSuperriorityVsYesterday){
            return false
        }
        let yesterday = auslesen_Statistics_Gestern(in: context, forThe: wortArt)
        if(yesterday == nil){
            return false
        }
        let yesterdayTime = yesterday!.learningTime
        let todayTime = today!.learningTime
        if(todayTime > yesterdayTime){
            return true
        }
        return false
    }
    public static func auslesen_Statistics_amDate(in context: NSManagedObjectContext, at date: Date, forThe wortArt: WortArt?)->TimeStatistics?{
        let theStamp = try! context.fetch(TimeStatistics.fetchRequest()).filter({$0.date == date && $0.relWortArt == wortArt}).first
        return theStamp
    }
    public static func auslesen_Statistics_Gestern(in context: NSManagedObjectContext, forThe wortArt: WortArt?)->TimeStatistics?{
        let theStamp = try! context.fetch(TimeStatistics.fetchRequest()).filter({$0.date == Date.now.offset_inDays(-1).stripTime() && $0.relWortArt == wortArt}).first
        return theStamp
    }
    public static func auslesen_Statistics_wochenAverage(in context: NSManagedObjectContext, forThe wortArt: WortArt?)->Double?{
        var timeStamps: [TimeStatistics] = []
        for theOffest in -7 ... -1{
            if let timeStamp = auslesen_Statistics_amDate(in: context, at: Date.now.offset_inDays(theOffest).stripTime(), forThe: wortArt){
                    timeStamps.append(timeStamp)
            }
        }
        if timeStamps.count == 0 {
            return nil
        }
        var total: Double = 0
        for theStamp in timeStamps{
            total += theStamp.learningTime
        }
        return total / Double(timeStamps.count)
    }
    public static func auslesen_WeeklyAverageLearningRatio(in context: NSManagedObjectContext, forThe wortArt: WortArt?)->Double?{
        var timeStamps: [TimeStatistics] = []
        for theOffest in -7 ... -1{
            if let timeStamp = auslesen_Statistics_amDate(in: context, at: Date.now.offset_inDays(theOffest).stripTime(), forThe: wortArt){
                    timeStamps.append(timeStamp)
            }
        }
        if timeStamps.count == 0 {
            return nil
        }
        var total: Double = 0
        for theStamp in timeStamps{
            total += Double(theStamp.completedFormen) / Double(theStamp.totalFormen)
        }
        return total / Double(timeStamps.count)
    }
    public static func auslesen_WeeklyAverageExam(in context: NSManagedObjectContext, forThe wortArt: WortArt?)->Double?{
        print("TimeStatistics.fetchWeeklyAverageExam: running for \(wortArt?.name_RU ?? "ALLES")")
        var timeStamps: [TimeStatistics] = []
        for theOffest in -7 ... -1{
            if let timeStamp = auslesen_Statistics_amDate(in: context, at: Date.now.offset_inDays(theOffest).stripTime(), forThe: wortArt){
                if(timeStamp.examCount > 0){
                    timeStamps.append(timeStamp)
                }
            }
        }
        print("   TimeStatistics.fetchWeeklyAverageExam: have found \(timeStamps.count) days with exams over previous 7 days")
        if timeStamps.count == 0 {
            return nil
        }
        var total: Double = 0
        for theStamp in timeStamps{
            total += Double(theStamp.examTotal) / Double(theStamp.examCount)
        }
        print("   TimeStatistics.fetchWeeklyAverageExam: total for those days was \(total), what give us average = \(total / Double(timeStamps.count))")
        return total / Double(timeStamps.count)
    }
    
    public static func auslesenOderAnlegen_LearningTime(in context: NSManagedObjectContext, at date: Date, forThe wortArt: WortArt?)->TimeStatistics{
        let theStamp = try! context.fetch(TimeStatistics.fetchRequest()).filter({$0.date == date && $0.relWortArt == wortArt}).first
        if theStamp != nil{
            return theStamp!
        }
        let newStamp = TimeStatistics(context: context)
        newStamp.date = date
        newStamp.learningTime = 0
        newStamp.relWortArt = wortArt
        try! context.save()
        return newStamp
    }
    
    public static func speichern_ExamResults(in context: NSManagedObjectContext, at date: Date, for examScore: Double, forThe wortArt: WortArt?){
        let theStamp = auslesenOderAnlegen_LearningTime(in: context, at: date, forThe: wortArt)
        theStamp.examTotal += examScore
        theStamp.examMin = min(theStamp.examMin, examScore)
        theStamp.examMax = max(theStamp.examMax, examScore)
        theStamp.examCount += 1
        try! context.save()
    }
    
    public static func berechnen_completion(in theContext: NSManagedObjectContext){
        do{
            var allWortFormenTotal: Int64 = 0
            var allWortFormenConfirmed: Int64 = 0

            for theWortArt in try theContext.fetch(WortArt.fetchRequest()) {
                var wortFormenTotal: Int64 = 0
                var wortFormenConfirmed: Int64 = 0

                for theWortFormen in (theWortArt.relWortFormen as? Set<WortFormen>) ?? [] {
                    let count = (theWortFormen.relWort as? Set<Wort>)?.count ?? 0
                    wortFormenTotal += Int64(count)
                    if(!theWortFormen.failed){
                        wortFormenConfirmed += Int64(count)
                    }else{
                        wortFormenConfirmed += max(theWortFormen.formsToShow - 1, 0)
                    }
                }
                
                var wortFormenTimeStats = TimeStatistics.auslesenOderAnlegen_LearningTime(in: theContext, at: Date.now.stripTime(), forThe: theWortArt)
                wortFormenTimeStats.totalFormen = Int64(wortFormenTotal)
                wortFormenTimeStats.completedFormen = Int64(wortFormenConfirmed)

                allWortFormenTotal += wortFormenTotal
                allWortFormenConfirmed += wortFormenConfirmed
            }
            
            var wortFormenTimeStats = TimeStatistics.auslesenOderAnlegen_LearningTime(in: theContext, at: Date.now.stripTime(), forThe: nil)
            wortFormenTimeStats.totalFormen = Int64(allWortFormenTotal)
            wortFormenTimeStats.completedFormen = Int64(allWortFormenConfirmed)
            
            try theContext.save()
        }catch{}
    }
    
    public static func speichern_LearningTime(in context: NSManagedObjectContext, at date: Date, for duration: Double, forThe wortArt: WortArt?){
        if(wortArt != nil){
            let theStamp = auslesenOderAnlegen_LearningTime(in: context, at: date, forThe: wortArt)
            theStamp.learningTime += duration
            //print("Learning time submitted at \(date) for \(theStamp.learningTime) for the \(wortArt!.name_RU)")
        }
        let genericStamp = auslesenOderAnlegen_LearningTime(in: context, at: date, forThe: nil)
        genericStamp.learningTime += duration
        //print("Learning time submitted at \(date) for \(genericStamp.learningTime) for the generic")
        try! context.save()
    }

}
