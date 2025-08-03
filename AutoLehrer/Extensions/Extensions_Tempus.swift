//
//  Extensions_Kasus.swift
//  AutoLehrer
//
//  Created by Алексей Хурсевич on 04.08.25.
//

import CoreData

extension Tempus{
    public static func findOrCreate(in context: NSManagedObjectContext, withName_DE name_DE: String) -> Tempus {
        var result: Tempus? = nil
        do{
            result = try context.fetch(Tempus.fetchRequest()).filter{$0.name_DE == name_DE}.first
            if result == nil {
                result = Tempus(context: context)
            }
        }catch{}
        return result!
    }
}

