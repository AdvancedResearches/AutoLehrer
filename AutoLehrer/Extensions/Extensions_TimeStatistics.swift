//
//  Extensions_TimeStatistics.swift
//  AutoLehrer
//
//  Created by Алексей Хурсевич on 30.08.25.
//

import CoreData

extension TimeStatistics{
    public static func submitLearningTime(in context: NSManagedObjectContext, at date: Date, from dateFrom: Date, to dateTo: Date){
        let theStamp = fetchOrCreateLearningTime(in: context, at: date)
        let timeSpan = dateTo.timeIntervalSince(dateFrom)
        theStamp.learningTime += timeSpan
        try! context.save()
    }
    public static func fetchLearningTime(in context: NSManagedObjectContext, at date: Date)->TimeStatistics?{
        return try! context.fetch(TimeStatistics.fetchRequest()).filter({$0.date == date}).first
        return nil
    }
    public static func fetchOrCreateLearningTime(in context: NSManagedObjectContext, at date: Date)->TimeStatistics{
        let theStamp = try! context.fetch(TimeStatistics.fetchRequest()).filter({$0.date == date}).first
        if theStamp != nil{
            return theStamp!
        }
        let newStamp = TimeStatistics(context: context)
        newStamp.date = date
        newStamp.learningTime = 0
        try! context.save()
        return newStamp
    }
}
