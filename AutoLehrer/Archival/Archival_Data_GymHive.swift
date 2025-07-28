//
//  Archival_Time.swift
//  DerTermin
//
//  Created by Алексей Хурсевич on 14.02.24.
//

import Foundation
import CoreData

/*
struct EquipmentHive: Codable{
    var theHive: [EquipmentItem]
}
struct EquipmentItem: Codable{
    var eqDescription: String
    var eqKey: String?
    var eqName: String
    var eqOrder: Int64
    var relEquipmentGroup: String
    var EquipmentID: String
    
    func pickInDB(_ context: NSManagedObjectContext) -> Equipment? {
        let hasAKey = (eqKey ?? "NIL") != "NIL"
        do{
            if(hasAKey){
                let foundItem = try context.fetch(Equipment.fetchRequest()).filter{$0.eqKey == eqKey}.first
                if(foundItem != nil){
                    return foundItem!
                }else{
                    let newItem = Equipment(context: context)
                    newItem.eqKey = eqKey
                    return newItem
                }
            }else{
                let newItem = Equipment(context: context)
                return newItem
            }
        }catch{}
        return nil
    }
}
*/

/*
struct GymHive: Codable{
    var equipmentHive: EquipmentHive?
    var equipmentGroupHive: EquipmentGroupHive?
    var equipmentLocationHive: EquipmentLocationHive?
    var equipmentWeightHive: EquipmentWeightHive?
    var equipmentWeightScaleHive: EquipmentWeightScaleHive?
    var equipmentXLocationHive: EquipmentXLocationHive?
    var exerciseHive: ExerciseHive?//
    var exerciseGoalHive: ExerciseGoalHive?//
    var exerciseGroupHive: ExerciseGroupHive?//
    var exerciseMetricHive: ExerciseMetricHive?//
    var exerciseTargetHive: ExerciseTargetHive?//
    var exerciseWeightHive: ExerciseWeightHive?//
    var exerciseXEquipmentHive: ExerciseXEquipmentHive?
    var exerciseXMuscleHive: ExerciseXMuscleHive?
    var exerciseXPatternHive: ExerciseXPatternHive?//
    var exerciseXTrainingHive: ExerciseXTrainingHive?//
    var milestoneHive: MilestoneHive?
    var muscleDevelopmentHive: MuscleDevelopmentHive?
    var muscleFatigueHive: MuscleFatigueHive?
    var muscleStatusHive: MuscleStatusHive?
    var patternHive: PatternHive?//
    var recurrencyHive: RecurrencyHive?//
    var recurrencyBindingHive: RecurrencyBindingHive?//
    var trainingHive: TrainingHive?//
    var weightAndHeightHive: WeightAndHeightHive?
}
 */

struct NameHive: Codable{
    var theHive: [NameItem]
}

struct NameItem: Codable{
    
}

struct VerbHive: Codable{
    var theHive: [VerbItem]
}

struct VerbItem: Codable{
    
}

struct AdjektivHive: Codable{
    var theHive: [AdjektivItem]
}

struct AdjektivItem: Codable{
    
}

struct FunktionalHive: Codable{
    var theHive: [FunktionalItem]
}

struct FunktionalItem: Codable{
    
}

struct PhraseHive: Codable{
    var theHive: [PhraseItem]
}

struct PhraseItem: Codable{
    
}

struct VocabularyHive: Codable{
    var nameHive: NameHive
    var verbHive: VerbHive
    var adjektivHive: AdjektivHive
    var funktonalHive: FunktionalHive
    var phraseHive: PhraseHive
}

struct Archival_Vocabulary{
    static func dump(theContext: NSManagedObjectContext) -> VocabularyHive{
        var retHive = VocabularyHive(
            nameHive: NameHive(theHive: []),
            verbHive: VerbHive(theHive: []),
            adjektivHive: AdjektivHive(theHive: []),
            funktonalHive: FunktionalHive(theHive: []),
            phraseHive: PhraseHive(theHive: [])
        )
        do{
            /*
            //equipment save
            var fetchedEquipment: [Equipment] = try theContext.fetch(Equipment.fetchRequest())
            var theEquipmentHive = EquipmentHive(theHive: [])
            for theEquipment in fetchedEquipment{
                let theEquipmentDump = EquipmentItem(
                    eqDescription: theEquipment.eqDescription ?? "",
                    eqKey: theEquipment.eqKey ?? "NIL",
                    eqName: theEquipment.eqName ?? "",
                    eqOrder: theEquipment.eqOrder,
                    relEquipmentGroup: theEquipment.relEquipmentGroup?.objectID.uriRepresentation().absoluteString ?? "NIL",
                    EquipmentID: theEquipment.objectID.uriRepresentation().absoluteString)
                theEquipmentHive.theHive.append(theEquipmentDump)
            }
            retHive.equipmentHive = theEquipmentHive
             */
        }catch{}
        
        return retHive
    }
    
    static func flush(theContext: NSManagedObjectContext, totalFlush: Bool = true){
        do{
            /*
            for theEquipment in try theContext.fetch(Equipment.fetchRequest()){
                theContext.delete(theEquipment)
            }
             */
            try theContext.save()
        }catch{
            
        }
    }
    
    static func restore_1_0_0_0(theContext: NSManagedObjectContext, theData: VocabularyHive){
        do{
            //flush
            flush(theContext: theContext, totalFlush: false)
            /*
            //exercise recovery
            var ExerciseDictionary: [String:Exercise] = [:]
            if(theData.exerciseHive != nil){
                for theExercise in theData.exerciseHive!.theHive{
                    let uploadingExercise = theExercise.pickInDB(theContext)!//Exercise(context: theContext)
                    if(theExercise.complexity != nil){
                        uploadingExercise.complexity = theExercise.complexity!
                    }
                    if(theExercise.eAction != nil){
                        uploadingExercise.eAction = theExercise.eAction!
                    }
                    uploadingExercise.eDisabled = theExercise.eDisabled
                    uploadingExercise.eName = theExercise.eName
                    uploadingExercise.eOrder = theExercise.eOrder
                    uploadingExercise.inFilter = theExercise.inFilter
                    uploadingExercise.pecularity = theExercise.pecularity ?? 2
                    uploadingExercise.eDescription = theExercise.eDescription
                    if(theExercise.relEG != "NIL"){
                        uploadingExercise.relEG = ExerciseGroupDictionary[theExercise.relEG]
                    }
                    ExerciseDictionary.updateValue(uploadingExercise, forKey: theExercise.ExerciseID)
                    try theContext.save()
                }
            }
             */
        }catch{
            return
        }
    }
    
    static func preset_1_0_0_0(theContext: NSManagedObjectContext, theData: VocabularyHive){
        do{
            //flush
            flush(theContext: theContext, totalFlush: false)
            /*
            //exercise recovery
            var ExerciseDictionary: [String:Exercise] = [:]
            if(theData.exerciseHive != nil){
                for theExercise in theData.exerciseHive!.theHive{
                    let uploadingExercise = theExercise.pickInDB(theContext)!//Exercise(context: theContext)
                    if(theExercise.complexity != nil){
                        uploadingExercise.complexity = theExercise.complexity!
                    }
                    if(theExercise.eAction != nil){
                        uploadingExercise.eAction = theExercise.eAction!
                    }
                    uploadingExercise.eDisabled = theExercise.eDisabled
                    uploadingExercise.eName = theExercise.eName
                    uploadingExercise.eOrder = theExercise.eOrder
                    uploadingExercise.inFilter = theExercise.inFilter
                    uploadingExercise.pecularity = theExercise.pecularity ?? 2
                    uploadingExercise.eDescription = theExercise.eDescription
                    if(theExercise.relEG != "NIL"){
                        uploadingExercise.relEG = ExerciseGroupDictionary[theExercise.relEG]
                    }
                    ExerciseDictionary.updateValue(uploadingExercise, forKey: theExercise.ExerciseID)
                    try theContext.save()
                }
            }
             */
        }catch{
            return
        }
    }
}
