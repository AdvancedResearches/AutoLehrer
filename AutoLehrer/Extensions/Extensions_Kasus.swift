//
//  Extensions_Kasus.swift
//  AutoLehrer
//
//  Created by Алексей Хурсевич on 04.08.25.
//

import CoreData

extension Kasus{
    public static func findOrCreate(in context: NSManagedObjectContext, withName_DE name_DE: String) -> Kasus {
        var result: Kasus? = nil
        do{
            result = try context.fetch(Kasus.fetchRequest()).filter{$0.name_DE == name_DE}.first
            if result == nil {
                result = Kasus(context: context)
            }
        }catch{}
        return result!
    }
}

