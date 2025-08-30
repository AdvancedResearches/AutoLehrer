//
//  Extensions_TimeStatistics.swift
//  AutoLehrer
//
//  Created by Алексей Хурсевич on 30.08.25.
//

import CoreData

extension TimeStatistics{
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
}
