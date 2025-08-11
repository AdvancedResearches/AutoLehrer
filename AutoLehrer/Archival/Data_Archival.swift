//
//  Archival_Helpers.swift
//  DerTermin
//
//  Created by Алексей Хурсевич on 14.02.24.
//

import Foundation
import CoreData
import SwiftUI

@MainActor
final class PresetsProgressOO: ObservableObject {
    @Published var text: String = "Обновление базы слов..."
    @Published var fraction: Double = 0.0   // 0.0–1.0, если захочешь прогресс-бар
    @Published var completed: Bool = false

    func reset() {
        text = "Обновление базы слов..."
        fraction = 0.0
        completed = false
    }
}

struct MasterHive: Codable{
    var version: String?
    var theVocabularyHive: VocabularyHive?
    var theSettingsHive: SettingsHive?
}

struct Data_Archival{
    
    var theFile: URL
    var theContext: NSManagedObjectContext
    
    func dump() -> Bool{
        var encoder : JSONEncoder
        encoder = JSONEncoder();
        encoder.outputFormatting = .prettyPrinted
        var encodedData: Data = Data()
        var masterHive: MasterHive = MasterHive()
        masterHive.version = "1.0.0.0"
        masterHive.theVocabularyHive = Archival_Vocabulary.dump(theContext: theContext)
        masterHive.theSettingsHive = Archival_Settings.dump(theContext: theContext)
        do{
            encodedData = try encoder.encode(masterHive)
            try encodedData.write(to: theFile)
        }catch let Error{
            //print("DUMPING FILE \(theFile.absoluteString) EXCEPTION, "+Error.localizedDescription)
            return false
        }
        return true
    }
    
    func flush() -> Bool {
        do{
            Archival_Vocabulary.flush(theContext: theContext)
            Archival_Settings.flush(theContext: theContext)
            try theContext.save()
        }catch{
            print("Failed to flush data")
            return false
        }
        return true
    }
    
    func restore() -> Bool {
        var restored: Bool = false
        do{
            let data = try Data(contentsOf: theFile)
            
            //split
            let decodedData = try JSONDecoder().decode(MasterHive.self, from: data)
            let version = decodedData.version
            
            if(version == "1.0.0.0"){
                if(decodedData.theVocabularyHive != nil){
                    Archival_Vocabulary.restore_1_0_0_0(theContext: theContext, theData: decodedData.theVocabularyHive!)
                }
                if(decodedData.theSettingsHive != nil){
                    Archival_Settings.restore_1_0_0_0(theContext: theContext, theData: decodedData.theSettingsHive!)
                }
                restored = true
            }
            try theContext.save()
        }catch{
            print("Failed to recover from archive")
        }
        return restored
    }
    
    func preset(progress: PresetsProgressOO) -> Bool {
        var restored: Bool = false
        do{
            let data = try Data(contentsOf: theFile)
            
            //split
            let decodedData = try JSONDecoder().decode(MasterHive.self, from: data)
            let version = decodedData.version
            
            if(version == "1.0.0.0"){
                if(decodedData.theVocabularyHive != nil){
                    Archival_Vocabulary.preset_1_0_0_0(theContext: theContext, theData: decodedData.theVocabularyHive!)
                }
                restored = true
            }
            try theContext.save()
        } catch {
            print("Failed to recover from preset: \(error.localizedDescription)")
        }
        return restored
    }
}

