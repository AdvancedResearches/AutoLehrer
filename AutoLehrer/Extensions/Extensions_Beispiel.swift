//
//  Extensions_Kasus.swift
//  AutoLehrer
//
//  Created by Алексей Хурсевич on 04.08.25.
//

import CoreData

extension Beispiel{
    public static func findOrCreate(in context: NSManagedObjectContext, withName_DE name_DE: String) -> Beispiel {
        var result: Beispiel? = nil
        do{
            result = try context.fetch(Beispiel.fetchRequest()).filter{$0.beispiel_DE == name_DE}.first
            if result == nil {
                result = Beispiel(context: context)
            }
        }catch{}
        return result!
    }
}

