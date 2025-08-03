//
//  Extensions_Deklination.swift
//  AutoLehrer
//
//  Created by Алексей Хурсевич on 04.08.25.
//

import CoreData

extension Deklination{
    public static func findOrCreate(in context: NSManagedObjectContext, withName_DE name_DE: String) -> Deklination {
        var result: Deklination? = nil
        do{
            result = try context.fetch(Deklination.fetchRequest()).filter{$0.name_DE == name_DE}.first
            if result == nil {
                result = Deklination(context: context)
            }
        }catch{}
        return result!
    }
}
