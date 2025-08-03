//
//  Extensions_Kasus.swift
//  AutoLehrer
//
//  Created by Алексей Хурсевич on 04.08.25.
//

import CoreData

extension Modus{
    public static func findOrCreate(in context: NSManagedObjectContext, withName_DE name_DE: String) -> Modus {
        var result: Modus? = nil
        do{
            result = try context.fetch(Modus.fetchRequest()).filter{$0.name_DE == name_DE}.first
            if result == nil {
                result = Modus(context: context)
            }
        }catch{}
        return result!
    }
}

