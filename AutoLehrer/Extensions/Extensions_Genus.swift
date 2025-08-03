//
//  Extension_Genus.swift
//  AutoLehrer
//
//  Created by Алексей Хурсевич on 04.08.25.
//

import CoreData

extension Genus{
    public static func findOrCreate(in context: NSManagedObjectContext, withName_DE name_DE: String) -> Genus {
        var result: Genus? = nil
        do{
            result = try context.fetch(Genus.fetchRequest()).filter{$0.name_DE == name_DE}.first
            if result == nil {
                result = Genus(context: context)
            }
        }catch{}
        return result!
    }
}
