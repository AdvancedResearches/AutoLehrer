//
//  Extensions_TimeStatistics.swift
//  AutoLehrer
//
//  Created by Алексей Хурсевич on 30.08.25.
//

import CoreData

extension TimeStatistics{
    public static func hasAnnouncedAboveAverage(in context: NSManagedObjectContext, forThe wortArt: WortArt?){
        if let today = fetchLearningTime(in: context, at: Date.now.stripTime(), forThe: wortArt){
            today.hasDeclaredSuperriorityVsAverage = true
            try! context.save()
        }
    }
    public static func isAboveAverageToAnnounce(in context: NSManagedObjectContext, forThe wortArt: WortArt?) -> Bool{
        let today = fetchLearningTime(in: context, at: Date.now.stripTime(), forThe: wortArt)
        if(today == nil){
            return false
        }
        if(today!.hasDeclaredSuperriorityVsAverage){
            return false
        }
        let average = fetchWeeklyAverageLearningTime(in: context, forThe: wortArt)
        if(average == nil){
            return false
        }
        let averageTime = fetchWeeklyAverageLearningTime(in: context, forThe: wortArt) ?? 0
        let todayTime = today!.learningTime
        if(todayTime > averageTime){
            return true
        }
        return false
    }
    public static func hasAnnouncedAboveYesterday(in context: NSManagedObjectContext, forThe wortArt: WortArt?){
        if let today = fetchLearningTime(in: context, at: Date.now.stripTime(), forThe: wortArt){
            today.hasDeclaredSuperriorityVsYesterday = true
            try! context.save()
        }
    }
    public static func isAboveYesterdayToAnnounce(in context: NSManagedObjectContext, forThe wortArt: WortArt?) -> Bool{
        let today = fetchLearningTime(in: context, at: Date.now.stripTime(), forThe: wortArt)
        if(today == nil){
            return false
        }
        if(today!.hasDeclaredSuperriorityVsYesterday){
            return false
        }
        let yesterday = fetchYesterdayLearningTime(in: context, forThe: wortArt)
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
    public static func submitLearningTime(in context: NSManagedObjectContext, at date: Date, for duration: Double, forThe wortArt: WortArt?){
        if(wortArt != nil){
            let theStamp = fetchOrCreateLearningTime(in: context, at: date, forThe: wortArt)
            theStamp.learningTime += duration
            print("Learning time submitted at \(date) for \(theStamp.learningTime) for the \(wortArt!.name_RU)")
        }
        let genericStamp = fetchOrCreateLearningTime(in: context, at: date, forThe: nil)
        genericStamp.learningTime += duration
        print("Learning time submitted at \(date) for \(genericStamp.learningTime) for the generic")
        try! context.save()
    }
    public static func fetchOrCreateLearningTime(in context: NSManagedObjectContext, at date: Date, forThe wortArt: WortArt?)->TimeStatistics{
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
    public static func fetchLearningTime(in context: NSManagedObjectContext, at date: Date, forThe wortArt: WortArt?)->TimeStatistics?{
        let theStamp = try! context.fetch(TimeStatistics.fetchRequest()).filter({$0.date == date && $0.relWortArt == wortArt}).first
        return theStamp
    }
    public static func fetchYesterdayLearningTime(in context: NSManagedObjectContext, forThe wortArt: WortArt?)->TimeStatistics?{
        let theStamp = try! context.fetch(TimeStatistics.fetchRequest()).filter({$0.date == Date.now.offset_inDays(-1).stripTime() && $0.relWortArt == wortArt}).first
        return theStamp
    }
    public static func fetchWeeklyAverageLearningTime(in context: NSManagedObjectContext, forThe wortArt: WortArt?)->Double?{
        var timeStamps: [TimeStatistics] = []
        for theOffest in -7 ..< -1{
            if let timeStamp = fetchLearningTime(in: context, at: Date.now.offset_inDays(theOffest).stripTime(), forThe: wortArt){
                    timeStamps.append(timeStamp)
            }
        }
        if timeStamps.count > 0 {
            return nil
        }
        var total: Double = 0
        for theStamp in timeStamps{
            total += theStamp.learningTime
        }
        return total / Double(timeStamps.count)
    }
}
