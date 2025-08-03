//
//  Extensions_Kasus.swift
//  AutoLehrer
//
//  Created by Алексей Хурсевич on 04.08.25.
//

import CoreData

extension Person{
    public static func findOrCreate(in context: NSManagedObjectContext, withName_DE name_DE: String) -> Person {
        var result: Person? = nil
        do{
            result = try context.fetch(Person.fetchRequest()).filter{$0.name_DE == name_DE}.first
            if result == nil {
                result = Person(context: context)
            }
        }catch{}
        return result!
    }
}

