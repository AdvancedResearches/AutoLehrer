//
//  Extension_Hoflichkeiten.swift
//  AutoLehrer
//
//  Created by Алексей Хурсевич on 14.08.25.
//

import CoreData

extension Hoflichkeiten{
    public static func findOrCreate(in context: NSManagedObjectContext, withName_DE name_DE: String) -> Hoflichkeiten {
        var result: Hoflichkeiten? = nil
        do{
            result = try context.fetch(Hoflichkeiten.fetchRequest()).filter{$0.name_DE == name_DE}.first
            if result == nil {
                result = Hoflichkeiten(context: context)
            }
        }catch{}
        return result!
    }
}
