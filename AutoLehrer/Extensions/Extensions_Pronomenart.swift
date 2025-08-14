//
//  Extension_Hoflichkeiten.swift
//  AutoLehrer
//
//  Created by Алексей Хурсевич on 14.08.25.
//

import CoreData

extension Pronomenart{
    public static func findOrCreate(in context: NSManagedObjectContext, withName_DE name_DE: String) -> Pronomenart {
        var result: Pronomenart? = nil
        do{
            result = try context.fetch(Pronomenart.fetchRequest()).filter{$0.name_DE == name_DE}.first
            if result == nil {
                result = Pronomenart(context: context)
            }
        }catch{}
        return result!
    }
}
