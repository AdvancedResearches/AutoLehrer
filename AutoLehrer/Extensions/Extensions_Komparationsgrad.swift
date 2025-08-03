//
//  Extensions_Kasus.swift
//  AutoLehrer
//
//  Created by Алексей Хурсевич on 04.08.25.
//

import CoreData

extension Komparationsgrad{
    public static func findOrCreate(in context: NSManagedObjectContext, withName_DE name_DE: String) -> Komparationsgrad {
        var result: Komparationsgrad? = nil
        do{
            result = try context.fetch(Komparationsgrad.fetchRequest()).filter{$0.name_DE == name_DE}.first
            if result == nil {
                result = Komparationsgrad(context: context)
            }
        }catch{}
        return result!
    }
}

