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

struct BeispielHive: Codable{
    var theHive: [BeispielItem]
}

struct BeispielItem: Codable{
    var beispiel_DE: String
    var beispiel_RU: String
    var relNomen: String
    var beispielKey: String
}

struct GenusHive: Codable{
    var theHive: [GenusItem]
}

struct GenusItem: Codable{
    var name_DE: String
    var name_RU: String
    var genusKey: String
}

struct KasusHive: Codable{
    var theHive: [KasusItem]
}

struct KasusItem: Codable{
    var fragen_DE: String
    var fragen_RU: String
    var name_DE: String
    var name_RU: String
    var kasusKey: String
}

struct NumerusHive: Codable{
    var theHive: [NumerusItem]
}

struct NumerusItem: Codable{
    var name_DE: String
    var name_RU: String
    var numerusKey: String
}

struct NomenDataHive: Codable{
    var theHive: [NomenItem]
}

struct NomenItem: Codable{
    var nomen_DE: String
    var nomen_RU: String
    var relGenus: String
    var relKasus: String
    var relNomenHive: String
    var relNumerus: String
    var nomenKey: String
}

struct nomenHiveHive: Codable{
    var theHive: [NomenHiveItem]
}

struct NomenHiveItem: Codable{
    var nomenFrequencyOrder: Int64
    var nomenHiveKey: String
}

struct VocabularyHive: Codable{
    var nomenDataHive: NomenDataHive
    var beispielHive: BeispielHive
    var genusHive: GenusHive
    var kasusHive: KasusHive
    var numerusHive: NumerusHive
    var nomenHiveHive: nomenHiveHive
}

struct Archival_Vocabulary{
    static func dump(theContext: NSManagedObjectContext) -> VocabularyHive{
        var retHive = VocabularyHive(
            nomenDataHive: NomenDataHive(theHive: []),
            beispielHive: BeispielHive(theHive: []),
            genusHive: GenusHive(theHive: []),
            kasusHive: KasusHive(theHive: []),
            numerusHive: NumerusHive(theHive: []),
            nomenHiveHive: nomenHiveHive(theHive: [])
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
            for theBeispiel in try theContext.fetch(Beispiel.fetchRequest()){
                theContext.delete(theBeispiel)
            }
            for theStatistics in try theContext.fetch(Statistics.fetchRequest()){
                theContext.delete(theStatistics)
            }
            for theNomenHive in try theContext.fetch(NomenHive.fetchRequest()){
                theContext.delete(theNomenHive)
            }
            for theNomen in try theContext.fetch(Nomen.fetchRequest()){
                theContext.delete(theNomen)
            }
            for theGenus in try theContext.fetch(Genus.fetchRequest()){
                theContext.delete(theGenus)
            }
            for theKasus in try theContext.fetch(Kasus.fetchRequest()){
                theContext.delete(theKasus)
            }
            for theNumerus in try theContext.fetch(Numerus.fetchRequest()){
                theContext.delete(theNumerus)
            }
            try theContext.save()
        }catch{
            
        }
    }
    
    static func restore_1_0_0_0(theContext: NSManagedObjectContext, theData: VocabularyHive){
        do{
            //flush
            flush(theContext: theContext, totalFlush: false)
            
            var GenusDictionary: [String:Genus] = [:]
            for theGenus in theData.genusHive.theHive{
                let uploadingGenus = Genus(context: theContext)
                uploadingGenus.name_DE = theGenus.name_DE
                uploadingGenus.name_RU = theGenus.name_RU
                GenusDictionary.updateValue(uploadingGenus, forKey: theGenus.genusKey)
            }
            
            var KasusDictionary: [String:Kasus] = [:]
            for theKasus in theData.kasusHive.theHive{
                let uploadingKasus = Kasus(context: theContext)
                uploadingKasus.name_DE = theKasus.name_DE
                uploadingKasus.name_RU = theKasus.name_RU
                uploadingKasus.fragen_DE = theKasus.fragen_DE
                uploadingKasus.fragen_RU = theKasus.fragen_RU
                KasusDictionary.updateValue(uploadingKasus, forKey: theKasus.kasusKey)
            }
            
            var NumerusDictionary: [String:Numerus] = [:]
            for theNumerus in theData.numerusHive.theHive{
                let uploadingNumerus = Numerus(context: theContext)
                uploadingNumerus.name_DE = theNumerus.name_DE
                uploadingNumerus.name_RU = theNumerus.name_RU
                NumerusDictionary.updateValue(uploadingNumerus, forKey: theNumerus.numerusKey)
            }
            
            var nomenHiveDictionary: [String:NomenHive] = [:]
            for theNomenHive in theData.nomenHiveHive.theHive{
                let uploadingNomenHive = NomenHive(context: theContext)
                uploadingNomenHive.nomenFrequencyOrder = theNomenHive.nomenFrequencyOrder
                nomenHiveDictionary.updateValue(uploadingNomenHive, forKey: theNomenHive.nomenHiveKey)
            }
            
            var NomenDictionary: [String:Nomen] = [:]
            for theNomen in theData.nomenDataHive.theHive{
                let uploadingNomen = Nomen(context: theContext)
                uploadingNomen.nomen_DE = theNomen.nomen_DE
                uploadingNomen.nomen_RU = theNomen.nomen_RU
                uploadingNomen.relGenus = GenusDictionary[theNomen.relGenus]
                uploadingNomen.relKasus = KasusDictionary[theNomen.relKasus]
                uploadingNomen.relNumerus = NumerusDictionary[theNomen.relNumerus]
                uploadingNomen.relNomenHive = nomenHiveDictionary[theNomen.relNomenHive]
                NomenDictionary.updateValue(uploadingNomen, forKey: theNomen.nomenKey)
            }
            
            var BeispielDictionary: [String:Beispiel] = [:]
            for theBeispel in theData.beispielHive.theHive{
                let uploadingBeispiel = Beispiel(context: theContext)
                uploadingBeispiel.beispiel_DE = theBeispel.beispiel_DE
                uploadingBeispiel.beispiel_RU = theBeispel.beispiel_RU
                uploadingBeispiel.relNomen = NomenDictionary[theBeispel.relNomen]
                BeispielDictionary.updateValue(uploadingBeispiel, forKey: theBeispel.beispielKey)
            }
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
            
            var GenusDictionary: [String:Genus] = [:]
            for theGenus in theData.genusHive.theHive{
                let uploadingGenus = Genus(context: theContext)
                uploadingGenus.name_DE = theGenus.name_DE
                uploadingGenus.name_RU = theGenus.name_RU
                GenusDictionary.updateValue(uploadingGenus, forKey: theGenus.genusKey)
            }
            
            var KasusDictionary: [String:Kasus] = [:]
            for theKasus in theData.kasusHive.theHive{
                let uploadingKasus = Kasus(context: theContext)
                uploadingKasus.name_DE = theKasus.name_DE
                uploadingKasus.name_RU = theKasus.name_RU
                uploadingKasus.fragen_DE = theKasus.fragen_DE
                uploadingKasus.fragen_RU = theKasus.fragen_RU
                KasusDictionary.updateValue(uploadingKasus, forKey: theKasus.kasusKey)
            }
            
            var NumerusDictionary: [String:Numerus] = [:]
            for theNumerus in theData.numerusHive.theHive{
                let uploadingNumerus = Numerus(context: theContext)
                uploadingNumerus.name_DE = theNumerus.name_DE
                uploadingNumerus.name_RU = theNumerus.name_RU
                NumerusDictionary.updateValue(uploadingNumerus, forKey: theNumerus.numerusKey)
            }
            
            var nomenHiveDictionary: [String:NomenHive] = [:]
            for theNomenHive in theData.nomenHiveHive.theHive{
                let uploadingNomenHive = NomenHive(context: theContext)
                uploadingNomenHive.nomenFrequencyOrder = theNomenHive.nomenFrequencyOrder
                nomenHiveDictionary.updateValue(uploadingNomenHive, forKey: theNomenHive.nomenHiveKey)
            }
            
            var NomenDictionary: [String:Nomen] = [:]
            for theNomen in theData.nomenDataHive.theHive{
                let uploadingNomen = Nomen(context: theContext)
                uploadingNomen.nomen_DE = theNomen.nomen_DE
                uploadingNomen.nomen_RU = theNomen.nomen_RU
                uploadingNomen.relGenus = GenusDictionary[theNomen.relGenus]
                uploadingNomen.relKasus = KasusDictionary[theNomen.relKasus]
                uploadingNomen.relNumerus = NumerusDictionary[theNomen.relNumerus]
                uploadingNomen.relNomenHive = nomenHiveDictionary[theNomen.relNomenHive]
                NomenDictionary.updateValue(uploadingNomen, forKey: theNomen.nomenKey)
            }
            
            var BeispielDictionary: [String:Beispiel] = [:]
            for theBeispel in theData.beispielHive.theHive{
                let uploadingBeispiel = Beispiel(context: theContext)
                uploadingBeispiel.beispiel_DE = theBeispel.beispiel_DE
                uploadingBeispiel.beispiel_RU = theBeispel.beispiel_RU
                uploadingBeispiel.relNomen = NomenDictionary[theBeispel.relNomen]
                BeispielDictionary.updateValue(uploadingBeispiel, forKey: theBeispel.beispielKey)
            }
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
