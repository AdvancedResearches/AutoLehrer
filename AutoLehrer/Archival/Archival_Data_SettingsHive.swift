//
//  Archival_Settings.swift
//  GymRat
//
//  Created by Алексей Хурсевич on 29.01.25.
//

import Foundation
import CoreData

struct SettingsItem: Codable{
    var settingName: String
    var settingValue: String
}

struct SettingsHive: Codable{
    var theHive: [SettingsItem]
}

struct Archival_Settings{
    static func dump(theContext: NSManagedObjectContext) -> SettingsHive{
        var retHive = SettingsHive(theHive: [])
        do{
            var fetchedSettings: [Settings] = try theContext.fetch(Settings.fetchRequest())
            var theSettingsHive = SettingsHive(theHive: [])
            for theSettings in fetchedSettings{
                let theSettingsDump = SettingsItem(settingName: theSettings.settingName!, settingValue: theSettings.settingValue!)
                theSettingsHive.theHive.append(theSettingsDump)
            }
            retHive = theSettingsHive
        }catch{}
        return retHive
    }
    
    static func flush(theContext: NSManagedObjectContext){
        do{
            for theSetting in try theContext.fetch(Settings.fetchRequest()){
                theContext.delete(theSetting)
            }
        }catch{}
    }
    
    static func restore_1_0_0_0(theContext: NSManagedObjectContext, theData: SettingsHive){
        do{
            //flush
            flush(theContext: theContext)
            
            for theSetting in theData.theHive{
                let uploadingSettting = Settings(context: theContext)
                uploadingSettting.settingName = theSetting.settingName
                uploadingSettting.settingValue = theSetting.settingValue
                try theContext.save()
            }
        }catch{
            return
        }
    }
}
