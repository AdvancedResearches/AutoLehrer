//
//  Extensions_Kasus.swift
//  AutoLehrer
//
//  Created by Алексей Хурсевич on 04.08.25.
//

import CoreData

extension Numerus{
    public static func findOrCreate(in context: NSManagedObjectContext, withName_DE name_DE: String) -> Numerus {
        var result: Numerus? = nil
        do{
            result = try context.fetch(Numerus.fetchRequest()).filter{$0.name_DE == name_DE}.first
            if result == nil {
                result = Numerus(context: context)
            }
        }catch{}
        return result!
    }
}

