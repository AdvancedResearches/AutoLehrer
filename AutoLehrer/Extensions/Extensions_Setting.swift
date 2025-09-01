//
//  Extensions_Setting.swift
//  GymRat
//
//  Created by Алексей Хурсевич on 08.02.24.
//

import Foundation
import CoreData

extension Settings {
    
    static func getLetztePrufung(in context: NSManagedObjectContext) -> Date? {
        if let letztePrufungValue = getValue(for: "letztePrufung", in: context) {
            let letztePrufung = Date.convert_StringToDate_DownToSecond(theString: letztePrufungValue)// Int64(timeAttackModeValue)!
            return letztePrufung
        } else {
            return nil
        }
    }
    static func setLetztePrufung(_ value: Date, in context: NSManagedObjectContext){
        setValue(Date.convert_DateToString_DownToSecond(theDate: value) , for: "letztePrufung", in: context)
    }
    
    static func getTimeAttackMode(in context: NSManagedObjectContext) -> Int64 {
        if let timeAttackModeValue = getValue(for: "timeAttackMode", in: context) {
            let timeAttackMode = Int64(timeAttackModeValue)!
            return timeAttackMode
        } else {
            setTimeAttackMode(5, in: context)
            return 5
        }
    }
    static func setTimeAttackMode(_ value: Int64, in context: NSManagedObjectContext){
        setValue(String(value), for: "timeAttackMode", in: context)
    }
    
    static func getLastLoadedVersion(in context: NSManagedObjectContext) -> Int64 {
        if let lastLoadedVersionString = getValue(for: "lastLoadedVersion", in: context) {
            let lastLoadedVersion = Int64(lastLoadedVersionString)!
            return lastLoadedVersion
        } else {
            setLastLoadedVersion(0, in: context)
            return 0
        }
    }
    static func setLastLoadedVersion(_ value: Int64, in context: NSManagedObjectContext){
        setValue(String(value), for: "lastLoadedVersion", in: context)
    }
    
    static func getGender(in context: NSManagedObjectContext) -> String {
        if let gender = getValue(for: "gender", in: context) {
            return gender
        } else {
            setGender("Undefined", in: context)
            return "Undefined"
        }
    }
    static func setGender(_ value: String, in context: NSManagedObjectContext){
        setValue(value, for: "gender", in: context)
    }
    
    static func getVeryFirstRun(in context: NSManagedObjectContext) -> Bool{
        if let veryFirstStart = getValue(for: "veryFirstRun", in: context) {
            setVeryFirstRun(false, in: context)
            //return true
            return Bool(veryFirstStart) ?? true
        } else {
            setVeryFirstRun(false, in: context)
            return true
        }
    }
    static func setVeryFirstRun(_ value: Bool, in context: NSManagedObjectContext) {
        setValue(String(value), for: "veryFirstRun", in: context)
    }
    //Specific
    //Color theme
    static func getTheme(in context: NSManagedObjectContext) -> String {
        if let locale = getValue(for: "theme", in: context) {
           return locale
        } else {
            setLocale("Regular_Bright", in: context)
            return "Regular_Bright"
        }
    }
    static func setTheme(_ value: String, in context: NSManagedObjectContext) {
        setValue(value, for: "theme", in: context)
    }
    //Planner dates
    static func getStartDateForPlanner(in context: NSManagedObjectContext) -> Date {
        if let dateString = getValue(for: "startDateForPlanner", in: context),
           let date = Date.convert_StringToDate_DownToSecond(theString: dateString) {
            return date
        } else {
            // Если настройки нет, создаем новую с сегодняшней датой
            let defaultDate = Date().stripTime()
            setStartDateForPlanner(defaultDate, in: context)
            return defaultDate
        }
    }
    static func setStartDateForPlanner(_ date: Date, in context: NSManagedObjectContext) {
        setValue(Date.convert_DateToString_DownToSecond(theDate: date), for: "startDateForPlanner", in: context)
    }
    static func getEndDateForPlanner(in context: NSManagedObjectContext) -> Date {
        if let dateString = getValue(for: "endDateForPlanner", in: context),
           let date = Date.convert_StringToDate_DownToSecond(theString: dateString) {
            return date
        } else {
            // Если настройки нет, создаем новую с датой + 1 неделя
            let defaultDate = Date().stripTime().offset_inDays(7)
            setEndDateForPlanner(defaultDate, in: context)
            return defaultDate
        }
    }
    static func setEndDateForPlanner(_ date: Date, in context: NSManagedObjectContext) {
        setValue(Date.convert_DateToString_DownToSecond(theDate: date), for: "endDateForPlanner", in: context)
    }
    //Statistics dates
    static func getStartDateForStatistics(in context: NSManagedObjectContext) -> Date {
            if let dateString = getValue(for: "startDateForStatistics", in: context),
               let date = Date.convert_StringToDate_DownToSecond(theString: dateString) {
                return date
            } else {
                // Если настройки нет, создаем новую с сегодняшней датой
                let defaultDate = Date().stripTime()
                setStartDateForStatistics(defaultDate, in: context)
                return defaultDate
            }
        }
    static func setStartDateForStatistics(_ date: Date, in context: NSManagedObjectContext) {
        setValue(Date.convert_DateToString_DownToSecond(theDate: date), for: "startDateForStatistics", in: context)
    }
    static func getEndDateForStatistics(in context: NSManagedObjectContext) -> Date {
        if let dateString = getValue(for: "endDateForStatistics", in: context),
            let date = Date.convert_StringToDate_DownToSecond(theString: dateString) {
            return date
        } else {
            // Если настройки нет, создаем новую с датой + 1 месяц
            let defaultDate = Date().stripTime().offset_inMonths(1)
            setEndDateForStatistics(defaultDate, in: context)
            return defaultDate
        }
    }
    static func setEndDateForStatistics(_ date: Date, in context: NSManagedObjectContext) {
        setValue(Date.convert_DateToString_DownToSecond(theDate: date), for: "endDateForStatistics", in: context)
    }
    //Has changed milestones
    static func getHasChangedMilestones(in context: NSManagedObjectContext) -> Bool {
        if let boolString = getValue(for: "hasChangedMilestones", in: context),
           let boolValue = Bool(boolString) {
            return boolValue
        } else {
            setHasChangedMilestones(true, in: context)
            return true
        }
    }
    static func setHasChangedMilestones(_ value: Bool, in context: NSManagedObjectContext) {
        setValue(String(value), for: "hasChangedMilestones", in: context)
    }
    //Locale
    static func getLocale(in context: NSManagedObjectContext) -> String {
        if let locale = getValue(for: "locale", in: context) {
           return locale
        } else {
            setLocale("EN", in: context)
            return "EN"
        }
    }
    static func setLocale(_ value: String, in context: NSManagedObjectContext) {
        setValue(value, for: "locale", in: context)
    }
    //Generic
    // Получение значения настройки по имени
    static func getValue(for name: String, in context: NSManagedObjectContext) -> String? {
        let fetchRequest: NSFetchRequest<Settings> = Settings.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "settingName == %@", name)
        fetchRequest.fetchLimit = 1
        
        do {
            if let setting = try context.fetch(fetchRequest).first {
                return setting.settingValue
            }
        } catch {
            print("Error fetching setting value for \(name): \(error.localizedDescription)")
        }
        return nil
    }
    // Установка значения настройки по имени
    static func setValue(_ value: String, for name: String, in context: NSManagedObjectContext) {
        let fetchRequest: NSFetchRequest<Settings> = Settings.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "settingName == %@", name)
        fetchRequest.fetchLimit = 1
        
        do {
            if let setting = try context.fetch(fetchRequest).first {
                setting.settingValue = value
            } else {
                // Если настройка не найдена, создаём новую
                let newSetting = Settings(context: context)
                newSetting.settingName = name
                newSetting.settingValue = value
            }
            
            // Сохраняем изменения в контексте
            try context.save()
        } catch {
            print("Error setting value for \(name): \(error.localizedDescription)")
        }
    }
}
