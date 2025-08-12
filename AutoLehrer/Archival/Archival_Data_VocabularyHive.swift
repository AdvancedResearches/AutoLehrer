//
//  Archival_Time.swift
//  DerTermin
//
//  Created by Алексей Хурсевич on 14.02.24.
//


import Foundation
import CoreData

struct VersionHive: Codable{
    var theHive: [VersionItem]
}

struct VersionItem: Codable{
    var version: Int64
}

struct BeispielHive: Codable{
    var theHive: [BeispielItem]
}

struct BeispielItem: Codable{
    var beispiel_DE: String
    var beispiel_RU: String
    var relWort: String
    var beispielKey: String
}

struct DeklinationHive: Codable{
    var theHive: [DeklinationItem]
}

struct DeklinationItem: Codable{
    var name_DE: String
    var name_RU: String
    var order: Int64
    var deklinationKey: String
}

struct GenusHive: Codable{
    var theHive: [GenusItem]
}

struct GenusItem: Codable{
    var name_DE: String
    var name_RU: String
    var order: Int64
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
    var order: Int64
    var kasusKey: String
}

struct KompatationsgradHive: Codable{
    var theHive: [KomparationsgradItem]
}

struct KomparationsgradItem: Codable{
    var name_DE: String
    var name_RU: String
    var order: Int64
    var komparationsgradKey: String
}

struct ModusHive: Codable{
    var theHive: [ModusItem]
}

struct ModusItem: Codable{
    var name_DE: String
    var name_RU: String
    var order: Int64
    var modusKey: String
}

struct NumerusHive: Codable{
    var theHive: [NumerusItem]
}

struct NumerusItem: Codable{
    var name_DE: String
    var name_RU: String
    var order: Int64
    var numerusKey: String
}

struct PersonHive: Codable{
    var theHive: [PersonItem]
}

struct PersonItem: Codable{
    var name_DE: String
    var name_RU: String
    var order: Int64
    var personKey: String
}

struct TempusHive: Codable{
    var theHive: [TempusItem]
}

struct TempusItem: Codable{
    var name_DE: String
    var name_RU: String
    var order: Int64
    var tempusKey: String
}

struct WortHive: Codable{
    var theHive: [WortItem]
}

struct WortItem: Codable{
    /*
     "wort_DE": "eine/die Zeit",
     "wort_RU": "время  ",
     "relDeklination": null,
     "relGenus": "weiblichGenus",
     "relKasus": "nominativeKasus",
     "relKomparationsgrad": null,
     "relModus": null,
     "relWortFormen": "NomenOrder1",
     "relNumerus": "singularNumerus",
     "relPerson": null,
     "relTempus": null,
     "wortKey": "eine/dieZeitweiblichGenusnominativeKasusNomenOrder1singularNumerus",
     */
    var wort_DE: String
    var wort_RU: String
    var relDeklination: String?
    var relGenus: String?
    var relKasus: String?
    var relKomparationsgrad: String?
    var relModus: String?
    var relNumerus: String?
    var relPerson: String?
    var relTempus: String?
    var relWortFormen: String
    var wortKey: String
}

struct WortArtHive: Codable{
    var theHive: [WortArtItem]
}

struct WortArtItem: Codable{
    var name_DE: String
    var name_RU: String
    var order: Int64
    var property_1: String?
    var property_2: String?
    var property_3: String?
    var property_4: String?
    var property_5: String?
    var property_6: String?
    var property_7: String?
    var property_8: String?
    var property_9: String?
    var property_10: String?
    var wortArtKey: String
}

struct WortFormenHive: Codable{
    var theHive: [WortFormenItem]
}

struct WortFormenItem: Codable{
    var wortFrequencyOrder: Int64
    var relWortArt: String
    var wortFormenKey: String
}

struct VocabularyHive: Codable{
    var beispielHive: BeispielHive
    var deklinationHive: DeklinationHive
    var genusHive: GenusHive
    var kasusHive: KasusHive
    var komparationsgradHive: KompatationsgradHive
    var modusHive: ModusHive
    var numerusHive: NumerusHive
    var personHive: PersonHive
    var tempusHive: TempusHive
    var versionHive: VersionHive
    var wortHive: WortHive
    var wortArtHive: WortArtHive
    var wortFormenHive: WortFormenHive
}

struct Archival_Vocabulary{
    static func dump(theContext: NSManagedObjectContext) -> VocabularyHive{
        var retHive = VocabularyHive(
            beispielHive: BeispielHive(theHive: []),
            deklinationHive: DeklinationHive(theHive: []),
            genusHive: GenusHive(theHive: []),
            kasusHive: KasusHive(theHive: []),
            komparationsgradHive: KompatationsgradHive(theHive: []),
            modusHive: ModusHive(theHive: []),
            numerusHive: NumerusHive(theHive: []),
            personHive: PersonHive(theHive: []),
            tempusHive: TempusHive(theHive: []),
            versionHive: VersionHive(theHive: []),
            wortHive: WortHive(theHive: []),
            wortArtHive: WortArtHive(theHive: []),
            wortFormenHive: WortFormenHive(theHive: [])
        )
        do{
        }catch{}
        
        return retHive
    }
    
    static func flush(theContext: NSManagedObjectContext, totalFlush: Bool = true){
        do{
            for theBeispiel in try theContext.fetch(Beispiel.fetchRequest()){
                theContext.delete(theBeispiel)
            }
            for theDeklination in try theContext.fetch(Deklination.fetchRequest()){
                theContext.delete(theDeklination)
            }
            for theStatistics in try theContext.fetch(Statistics.fetchRequest()){
                theContext.delete(theStatistics)
            }
            for theWortFormenHive in try theContext.fetch(WortFormen.fetchRequest()){
                theContext.delete(theWortFormenHive)
            }
            for theWort in try theContext.fetch(Wort.fetchRequest()){
                theContext.delete(theWort)
            }
            for theGenus in try theContext.fetch(Genus.fetchRequest()){
                theContext.delete(theGenus)
            }
            for theKasus in try theContext.fetch(Kasus.fetchRequest()){
                theContext.delete(theKasus)
            }
            for theKomparationsgrad in try theContext.fetch(Komparationsgrad.fetchRequest()){
                theContext.delete(theKomparationsgrad)
            }
            for theModus in try theContext.fetch(Modus.fetchRequest()){
                theContext.delete(theModus)
            }
            for theNumerus in try theContext.fetch(Numerus.fetchRequest()){
                theContext.delete(theNumerus)
            }
            for thePerson in try theContext.fetch(Person.fetchRequest()){
                theContext.delete(thePerson)
            }
            for theTempus in try theContext.fetch(Tempus.fetchRequest()){
                theContext.delete(theTempus)
            }
            for theWortArt in try theContext.fetch(WortArt.fetchRequest()){
                theContext.delete(theWortArt)
            }
            try theContext.save()
        }catch{
            
        }
    }
    
    static func restore_1_0_0_0(theContext: NSManagedObjectContext, theData: VocabularyHive){
        do{
            //flush
            flush(theContext: theContext, totalFlush: false)
        }catch{
            return
        }
    }
    
    static func preset_1_0_0_0(
            theContext: NSManagedObjectContext,
            theData: VocabularyHive,
            progress: PresetsProgressOO
        ) {
        do{
            
            var fullCount = 0
            var runningCounter = 0
            
            //flush
            //flush(theContext: theContext, totalFlush: false)
            print("Start preset_1_0_0_0: Start")
            
            var shallBeLoaded = false
            var presetVersion: Int64 = 0
            
            for theVersion in theData.versionHive.theHive{
                presetVersion = theVersion.version
                let lastLoadedVersion = Settings.getLastLoadedVersion(in: theContext)
                shallBeLoaded = presetVersion > lastLoadedVersion
            }
            
            if(shallBeLoaded){
                
                Task { @MainActor in progress.text = "Обновление базы слов...\nИмпорт: склонения…" }
                
                runningCounter = 0
                fullCount = theData.deklinationHive.theHive.count
                var DeklinationDictionary: [String:Deklination] = [:]
                for theDeklination in theData.deklinationHive.theHive{
                    let uploadingDeklination = Deklination.findOrCreate(in: theContext, withName_DE: theDeklination.name_DE)//Deklination(context: theContext)
                    uploadingDeklination.name_DE = theDeklination.name_DE
                    uploadingDeklination.name_RU = theDeklination.name_RU
                    uploadingDeklination.order = theDeklination.order
                    DeklinationDictionary.updateValue(uploadingDeklination, forKey: theDeklination.deklinationKey)
                    runningCounter += 1
                    Task { @MainActor in progress.fraction = Double(runningCounter)/Double(fullCount) }
                }
                let existingDeklinations: [Deklination] = try theContext.fetch(Deklination.fetchRequest())
                runningCounter = 0
                fullCount = existingDeklinations.count
                for theExistingDeklination in existingDeklinations{
                    if(!DeklinationDictionary.values.contains(theExistingDeklination)){
                        theContext.delete(theExistingDeklination)
                    }
                    runningCounter += 1
                    Task { @MainActor in progress.fraction = Double(runningCounter)/Double(fullCount) }
                }
                print("Start preset_1_0_0_0: Deklination loaded")
                
                Task { @MainActor in progress.text = "Обновление базы слов...\nИмпорт: склонения… ЗАВЕРШЕНО\nИмпорт: рода..." }
                
                runningCounter = 0
                fullCount = theData.genusHive.theHive.count
                var GenusDictionary: [String:Genus] = [:]
                for theGenus in theData.genusHive.theHive{
                    let uploadingGenus = Genus.findOrCreate(in: theContext, withName_DE: theGenus.name_DE)//Genus(context: theContext)
                    uploadingGenus.name_DE = theGenus.name_DE
                    uploadingGenus.name_RU = theGenus.name_RU
                    uploadingGenus.order = theGenus.order
                    GenusDictionary.updateValue(uploadingGenus, forKey: theGenus.genusKey)
                    runningCounter += 1
                    Task { @MainActor in progress.fraction = Double(runningCounter)/Double(fullCount) }
                }
                let existingGenus: [Genus] = try theContext.fetch(Genus.fetchRequest())
                runningCounter = 0
                fullCount = existingGenus.count
                for theExistingGenus in existingGenus{
                    if(!GenusDictionary.values.contains(theExistingGenus)){
                        theContext.delete(theExistingGenus)
                    }
                    runningCounter += 1
                    Task { @MainActor in progress.fraction = Double(runningCounter)/Double(fullCount) }
                }
                print("Start preset_1_0_0_0: Genus loaded")
                
                Task { @MainActor in progress.text = "Обновление базы слов...\nИмпорт: склонения… ЗАВЕРШЕНО\nИмпорт: рода...ЗАВЕРШЕНО\nИмпорт: Падежи..." }
                
                runningCounter = 0
                fullCount = theData.kasusHive.theHive.count
                var KasusDictionary: [String:Kasus] = [:]
                for theKasus in theData.kasusHive.theHive{
                    let uploadingKasus = Kasus.findOrCreate(in: theContext, withName_DE: theKasus.name_DE)//Kasus(context: theContext)
                    uploadingKasus.name_DE = theKasus.name_DE
                    uploadingKasus.name_RU = theKasus.name_RU
                    uploadingKasus.fragen_DE = theKasus.fragen_DE
                    uploadingKasus.fragen_RU = theKasus.fragen_RU
                    uploadingKasus.order = theKasus.order
                    KasusDictionary.updateValue(uploadingKasus, forKey: theKasus.kasusKey)
                    runningCounter += 1
                    Task { @MainActor in progress.fraction = Double(runningCounter)/Double(fullCount) }
                }
                let existingKasus: [Kasus] = try theContext.fetch(Kasus.fetchRequest())
                runningCounter = 0
                fullCount = existingKasus.count
                for theExistingKasus in existingKasus{
                    if(!KasusDictionary.values.contains(theExistingKasus)){
                        theContext.delete(theExistingKasus)
                    }
                    runningCounter += 1
                    Task { @MainActor in progress.fraction = Double(runningCounter)/Double(fullCount) }
                }
                print("Start preset_1_0_0_0: Kasus loaded")
                
                Task { @MainActor in progress.text = "Обновление базы слов...\nИмпорт: склонения… ЗАВЕРШЕНО\nИмпорт: рода...ЗАВЕРШЕНО\nИмпорт: Падежи...ЗАВЕРШЕНО\nИмпорт: Сравнительные степени..." }
                
                runningCounter = 0
                fullCount = theData.komparationsgradHive.theHive.count
                var KomparationsgradDictionary: [String:Komparationsgrad] = [:]
                for theKomparationsgrad in theData.komparationsgradHive.theHive{
                    let uploadingKomparationsgrad = Komparationsgrad.findOrCreate(in: theContext, withName_DE: theKomparationsgrad.name_DE)//Komparationsgrad(context: theContext)
                    uploadingKomparationsgrad.name_DE = theKomparationsgrad.name_DE
                    uploadingKomparationsgrad.name_RU = theKomparationsgrad.name_RU
                    uploadingKomparationsgrad.order = theKomparationsgrad.order
                    KomparationsgradDictionary.updateValue(uploadingKomparationsgrad, forKey: theKomparationsgrad.komparationsgradKey)
                    runningCounter += 1
                    Task { @MainActor in progress.fraction = Double(runningCounter)/Double(fullCount) }
                }
                let existingKomparationsgrad: [Komparationsgrad] = try theContext.fetch(Komparationsgrad.fetchRequest())
                runningCounter = 0
                fullCount = existingKomparationsgrad.count
                for theExistingKomparationsgrad in existingKomparationsgrad{
                    if(!KomparationsgradDictionary.values.contains(theExistingKomparationsgrad)){
                        theContext.delete(theExistingKomparationsgrad)
                    }
                    runningCounter += 1
                    Task { @MainActor in progress.fraction = Double(runningCounter)/Double(fullCount) }
                }
                print("Start preset_1_0_0_0: Komparationsgrad loaded")
                
                Task { @MainActor in progress.text = "Обновление базы слов...\nИмпорт: склонения… ЗАВЕРШЕНО\nИмпорт: рода...ЗАВЕРШЕНО\nИмпорт: Падежи...ЗАВЕРШЕНО\nИмпорт: Сравнительные степени...ЗАВЕРШЕНО\nИмпорт: Модальность..." }
                
                runningCounter = 0
                fullCount = theData.modusHive.theHive.count
                var ModusDictionary: [String:Modus] = [:]
                for theModus in theData.modusHive.theHive{
                    let uploadingModus = Modus.findOrCreate(in: theContext, withName_DE: theModus.name_DE)//Modus(context: theContext)
                    uploadingModus.name_DE = theModus.name_DE
                    uploadingModus.name_RU = theModus.name_RU
                    uploadingModus.order = theModus.order
                    ModusDictionary.updateValue(uploadingModus, forKey: theModus.modusKey)
                    runningCounter += 1
                    Task { @MainActor in progress.fraction = Double(runningCounter)/Double(fullCount) }
                }
                let existingModus: [Modus] = try theContext.fetch(Modus.fetchRequest())
                runningCounter = 0
                fullCount = existingModus.count
                for theExistingModus in existingModus{
                    if(!ModusDictionary.values.contains(theExistingModus)){
                        theContext.delete(theExistingModus)
                    }
                    runningCounter += 1
                    Task { @MainActor in progress.fraction = Double(runningCounter)/Double(fullCount) }
                }
                print("Start preset_1_0_0_0: Modus loaded")
                
                Task { @MainActor in progress.text = "Обновление базы слов...\nИмпорт: склонения… ЗАВЕРШЕНО\nИмпорт: рода...ЗАВЕРШЕНО\nИмпорт: Падежи...ЗАВЕРШЕНО\nИмпорт: Сравнительные степени...ЗАВЕРШЕНО\nИмпорт: Модальность...ЗАВЕРШЕНО\nИмпорт: Числа..." }
                
                runningCounter = 0
                fullCount = theData.numerusHive.theHive.count
                var NumerusDictionary: [String:Numerus] = [:]
                for theNumerus in theData.numerusHive.theHive{
                    let uploadingNumerus = Numerus.findOrCreate(in: theContext, withName_DE: theNumerus.name_DE)//Numerus(context: theContext)
                    uploadingNumerus.name_DE = theNumerus.name_DE
                    uploadingNumerus.name_RU = theNumerus.name_RU
                    uploadingNumerus.order = theNumerus.order
                    NumerusDictionary.updateValue(uploadingNumerus, forKey: theNumerus.numerusKey)
                    runningCounter += 1
                    Task { @MainActor in progress.fraction = Double(runningCounter)/Double(fullCount) }
                }
                let existingNumerus: [Numerus] = try theContext.fetch(Numerus.fetchRequest())
                runningCounter = 0
                fullCount = existingNumerus.count
                for theExistingNumerus in existingNumerus{
                    if(!NumerusDictionary.values.contains(theExistingNumerus)){
                        theContext.delete(theExistingNumerus)
                    }
                    runningCounter += 1
                    Task { @MainActor in progress.fraction = Double(runningCounter)/Double(fullCount) }
                }
                print("Start preset_1_0_0_0: Numerus loaded")
                
                Task { @MainActor in progress.text = "Обновление базы слов...\nИмпорт: склонения… ЗАВЕРШЕНО\nИмпорт: рода...ЗАВЕРШЕНО\nИмпорт: Падежи...ЗАВЕРШЕНО\nИмпорт: Сравнительные степени...ЗАВЕРШЕНО\nИмпорт: Модальность...ЗАВЕРШЕНО\nИмпорт: Числа...ЗАВЕРШЕНО\nИмпорт: Лица..." }
                
                runningCounter = 0
                fullCount = theData.personHive.theHive.count
                var PersonDictionary: [String:Person] = [:]
                for thePerson in theData.personHive.theHive{
                    let uploadingPerson = Person.findOrCreate(in: theContext, withName_DE: thePerson.name_DE)//Person(context: theContext)
                    uploadingPerson.name_DE = thePerson.name_DE
                    uploadingPerson.name_RU = thePerson.name_RU
                    uploadingPerson.order = thePerson.order
                    PersonDictionary.updateValue(uploadingPerson, forKey: thePerson.personKey)
                    runningCounter += 1
                    Task { @MainActor in progress.fraction = Double(runningCounter)/Double(fullCount) }
                }
                let existingPerson: [Person] = try theContext.fetch(Person.fetchRequest())
                runningCounter = 0
                fullCount = existingPerson.count
                for theExistingPerson in existingPerson{
                    if(!PersonDictionary.values.contains(theExistingPerson)){
                        theContext.delete(theExistingPerson)
                    }
                    runningCounter += 1
                    Task { @MainActor in progress.fraction = Double(runningCounter)/Double(fullCount) }
                }
                print("Start preset_1_0_0_0: Person loaded")
                
                Task { @MainActor in progress.text = "Обновление базы слов...\nИмпорт: склонения… ЗАВЕРШЕНО\nИмпорт: рода...ЗАВЕРШЕНО\nИмпорт: Падежи...ЗАВЕРШЕНО\nИмпорт: Сравнительные степени...ЗАВЕРШЕНО\nИмпорт: Модальность...ЗАВЕРШЕНО\nИмпорт: Числа...ЗАВЕРШЕНО\nИмпорт: Лица...ЗАВЕРШЕНО\nИмпорт: Времена..." }
                
                runningCounter = 0
                fullCount = theData.tempusHive.theHive.count
                var TempusDictionary: [String:Tempus] = [:]
                for theTempus in theData.tempusHive.theHive{
                    let uploadingTempus = Tempus.findOrCreate(in: theContext, withName_DE: theTempus.name_DE)//Tempus(context: theContext)
                    uploadingTempus.name_DE = theTempus.name_DE
                    uploadingTempus.name_RU = theTempus.name_RU
                    uploadingTempus.order = theTempus.order
                    TempusDictionary.updateValue(uploadingTempus, forKey: theTempus.tempusKey)
                    runningCounter += 1
                    Task { @MainActor in progress.fraction = Double(runningCounter)/Double(fullCount) }
                }
                let existingTempus: [Tempus] = try theContext.fetch(Tempus.fetchRequest())
                runningCounter = 0
                fullCount = existingTempus.count
                for theExistingTempus in existingTempus{
                    if(!TempusDictionary.values.contains(theExistingTempus)){
                        theContext.delete(theExistingTempus)
                    }
                    runningCounter += 1
                    Task { @MainActor in progress.fraction = Double(runningCounter)/Double(fullCount) }
                }
                print("Start preset_1_0_0_0: Tempus loaded")
                
                Task { @MainActor in progress.text = "Обновление базы слов...\nИмпорт: склонения… ЗАВЕРШЕНО\nИмпорт: рода...ЗАВЕРШЕНО\nИмпорт: Падежи...ЗАВЕРШЕНО\nИмпорт: Сравнительные степени...ЗАВЕРШЕНО\nИмпорт: Модальность...ЗАВЕРШЕНО\nИмпорт: Числа...ЗАВЕРШЕНО\nИмпорт: Лица...ЗАВЕРШЕНО\nИмпорт: Времена...ЗАВЕРШЕНО\nИмпорт: Слова..." }
                
                runningCounter = 0
                fullCount = theData.wortArtHive.theHive.count
                var WortArtDictionary: [String:WortArt] = [:]
                for theWortArt in theData.wortArtHive.theHive{
                    let uploadingWortArt = WortArt.findOrCreate(in: theContext, withName_DE: theWortArt.name_DE)//WortArt(context: theContext)
                    uploadingWortArt.name_DE = theWortArt.name_DE
                    uploadingWortArt.name_RU = theWortArt.name_RU
                    uploadingWortArt.order = theWortArt.order
                    uploadingWortArt.property_1 = theWortArt.property_1
                    uploadingWortArt.property_2 = theWortArt.property_2
                    uploadingWortArt.property_3 = theWortArt.property_3
                    uploadingWortArt.property_4 = theWortArt.property_4
                    uploadingWortArt.property_5 = theWortArt.property_5
                    uploadingWortArt.property_6 = theWortArt.property_6
                    uploadingWortArt.property_7 = theWortArt.property_7
                    uploadingWortArt.property_8 = theWortArt.property_8
                    uploadingWortArt.property_9 = theWortArt.property_9
                    uploadingWortArt.property_10 = theWortArt.property_10
                    WortArtDictionary.updateValue(uploadingWortArt, forKey: theWortArt.wortArtKey)
                    runningCounter += 1
                    Task { @MainActor in progress.fraction = Double(runningCounter)/Double(fullCount) }
                }
                let existingWortArt: [WortArt] = try theContext.fetch(WortArt.fetchRequest())
                runningCounter = 0
                fullCount = existingWortArt.count
                for theExistingWortArt in existingWortArt{
                    if(!WortArtDictionary.values.contains(theExistingWortArt)){
                        theContext.delete(theExistingWortArt)
                    }
                    runningCounter += 1
                    Task { @MainActor in progress.fraction = Double(runningCounter)/Double(fullCount) }
                }
                print("Start preset_1_0_0_0: WortArt loaded")
                
                Task { @MainActor in progress.text = "Обновление базы слов...\nИмпорт: склонения… ЗАВЕРШЕНО\nИмпорт: рода...ЗАВЕРШЕНО\nИмпорт: Падежи...ЗАВЕРШЕНО\nИмпорт: Сравнительные степени...ЗАВЕРШЕНО\nИмпорт: Модальность...ЗАВЕРШЕНО\nИмпорт: Числа...ЗАВЕРШЕНО\nИмпорт: Лица...ЗАВЕРШЕНО\nИмпорт: Времена...ЗАВЕРШЕНО\nИмпорт: Слова...ЗАВЕРШЕНО\nИмпорт: Формы слов..." }
                
                runningCounter = 0
                fullCount = theData.wortFormenHive.theHive.count
                var WortFormenDictionary: [String:WortFormen] = [:]
                for theWortFormen in theData.wortFormenHive.theHive{
                    let uploadingWortFormen = WortFormen.findOrCreate(in: theContext, wortArt: WortArtDictionary[theWortFormen.relWortArt], order: theWortFormen.wortFrequencyOrder)//WortFormen(context: theContext)
                    uploadingWortFormen.wortFrequencyOrder = theWortFormen.wortFrequencyOrder
                    uploadingWortFormen.relWortArt    = WortArtDictionary[theWortFormen.relWortArt]!
                    WortFormenDictionary.updateValue(uploadingWortFormen, forKey: theWortFormen.wortFormenKey)
                    runningCounter += 1
                    Task { @MainActor in progress.fraction = Double(runningCounter)/Double(fullCount) }
                }
                let existingWortFormen: [WortFormen] = try theContext.fetch(WortFormen.fetchRequest())
                runningCounter = 0
                fullCount = existingWortFormen.count
                for theExistingWortFormen in existingWortFormen{
                    if(!WortFormenDictionary.values.contains(theExistingWortFormen)){
                        theContext.delete(theExistingWortFormen)
                    }
                    runningCounter += 1
                    Task { @MainActor in progress.fraction = Double(runningCounter)/Double(fullCount) }
                }
                print("Start preset_1_0_0_0: WortFormen loaded")
                
                Task { @MainActor in progress.text = "Обновление базы слов...\nИмпорт: склонения… ЗАВЕРШЕНО\nИмпорт: рода...ЗАВЕРШЕНО\nИмпорт: Падежи...ЗАВЕРШЕНО\nИмпорт: Сравнительные степени...ЗАВЕРШЕНО\nИмпорт: Модальность...ЗАВЕРШЕНО\nИмпорт: Числа...ЗАВЕРШЕНО\nИмпорт: Лица...ЗАВЕРШЕНО\nИмпорт: Времена...ЗАВЕРШЕНО\nИмпорт: Слова...ЗАВЕРШЕНО\nИмпорт: Формы слов...ЗАВЕРШЕНО\nИмпорт: Изменения слов..." }
                
                runningCounter = 0
                fullCount = theData.wortHive.theHive.count
                var WortDictionary: [String:Wort] = [:]
                for theWort in theData.wortHive.theHive{
                    let uploadingWort = Wort.findOrCreate(in: theContext, wortFormen: WortFormenDictionary[theWort.relWortFormen]!, wortArtFormen: WortArtFormen(
                        deklination: DeklinationDictionary[theWort.relDeklination ?? "NIL"],
                        genus: GenusDictionary[theWort.relGenus ?? "NIL"],
                        kasus: KasusDictionary[theWort.relKasus ?? "NIL"],
                        komparationsgrad: KomparationsgradDictionary[theWort.relKomparationsgrad ?? "NIL"],
                        modus: ModusDictionary[theWort.relModus ?? "NIL"],
                        numerus: NumerusDictionary[theWort.relNumerus ?? "NIL"],
                        person: PersonDictionary[theWort.relPerson ?? "NIL"],
                        tempus: TempusDictionary[theWort.relTempus ?? "NIL"]
                    ))
                    uploadingWort.wort_DE = theWort.wort_DE
                    uploadingWort.wort_RU = theWort.wort_RU
                    
                    uploadingWort.relDeklination        = DeklinationDictionary[theWort.relDeklination ?? "NIL"]
                    uploadingWort.relGenus              = GenusDictionary[theWort.relGenus ?? "NIL"]
                    uploadingWort.relKasus              = KasusDictionary[theWort.relKasus ?? "NIL"]
                    uploadingWort.relKomparationsgrad   = KomparationsgradDictionary[theWort.relKomparationsgrad ?? "NIL"]
                    uploadingWort.relModus              = ModusDictionary[theWort.relModus ?? "NIL"]
                    uploadingWort.relNumerus            = NumerusDictionary[theWort.relNumerus ?? "NIL"]
                    uploadingWort.relPerson             = PersonDictionary[theWort.relPerson ?? "NIL"]
                    uploadingWort.relTempus             = TempusDictionary[theWort.relTempus ?? "NIL"]
                    
                    uploadingWort.relWortFormen = WortFormenDictionary[theWort.relWortFormen]!
                    WortDictionary.updateValue(uploadingWort, forKey: theWort.wortKey)
                    
                    print("Start preset_1_0_0_0: new Wort \(uploadingWort.wort_DE) loaded")
                    
                    runningCounter += 1
                    Task { @MainActor in progress.fraction = Double(runningCounter)/Double(fullCount) }
                }
                print("Start preset_1_0_0_0: new Wort loaded")
                let existingWort: [Wort] = try theContext.fetch(Wort.fetchRequest())
                runningCounter = 0
                fullCount = existingWort.count
                for theExistingWort in existingWort{
                    if(!WortDictionary.values.contains(theExistingWort)){
                        theContext.delete(theExistingWort)
                    }
                    runningCounter += 1
                    Task { @MainActor in progress.fraction = Double(runningCounter)/Double(fullCount) }
                }
                print("Start preset_1_0_0_0: Wort loaded")
                
                Task { @MainActor in progress.text = "Обновление базы слов...\nИмпорт: склонения… ЗАВЕРШЕНО\nИмпорт: рода...ЗАВЕРШЕНО\nИмпорт: Падежи...ЗАВЕРШЕНО\nИмпорт: Сравнительные степени...ЗАВЕРШЕНО\nИмпорт: Модальность...ЗАВЕРШЕНО\nИмпорт: Числа...ЗАВЕРШЕНО\nИмпорт: Лица...ЗАВЕРШЕНО\nИмпорт: Времена...ЗАВЕРШЕНО\nИмпорт: Слова...ЗАВЕРШЕНО\nИмпорт: Формы слов...ЗАВЕРШЕНО\nИмпорт: Изменения слов...ЗАВЕРШЕНО\nИмпорт: Примеры..." }
                
                runningCounter = 0
                fullCount = theData.beispielHive.theHive.count
                var BeispielDictionary: [String:Beispiel] = [:]
                for theBeispel in theData.beispielHive.theHive{
                    let uploadingBeispiel = Beispiel.findOrCreate(in: theContext, withName_DE: theBeispel.beispiel_DE)//Beispiel(context: theContext)
                    uploadingBeispiel.beispiel_DE = theBeispel.beispiel_DE
                    uploadingBeispiel.beispiel_RU = theBeispel.beispiel_RU
                    uploadingBeispiel.relWort = WortDictionary[theBeispel.relWort]
                    BeispielDictionary.updateValue(uploadingBeispiel, forKey: theBeispel.beispielKey)
                    runningCounter += 1
                    Task { @MainActor in progress.fraction = Double(runningCounter)/Double(fullCount) }
                }
                let existingBeispiel: [Beispiel] = try theContext.fetch(Beispiel.fetchRequest())
                runningCounter = 0
                fullCount = existingBeispiel.count
                for theExistingBeispliel in existingBeispiel{
                    if(!BeispielDictionary.values.contains(theExistingBeispliel)){
                        theContext.delete(theExistingBeispliel)
                    }
                    runningCounter += 1
                    Task { @MainActor in progress.fraction = Double(runningCounter)/Double(fullCount) }
                }
                print("Start preset_1_0_0_0: Beispiel loaded")
                
                Task { @MainActor in progress.text = "Обновление базы слов...\nИмпорт: склонения… ЗАВЕРШЕНО\nИмпорт: рода...ЗАВЕРШЕНО\nИмпорт: Падежи...ЗАВЕРШЕНО\nИмпорт: Сравнительные степени...ЗАВЕРШЕНО\nИмпорт: Модальность...ЗАВЕРШЕНО\nИмпорт: Числа...ЗАВЕРШЕНО\nИмпорт: Лица...ЗАВЕРШЕНО\nИмпорт: Времена...ЗАВЕРШЕНО\nИмпорт: Слова...ЗАВЕРШЕНО\nИмпорт: Формы слов...ЗАВЕРШЕНО\nИмпорт: Изменения слов...ЗАВЕРШЕНО\nИмпорт: Примеры...ЗАВЕРШЕНО\nПересчёт заученного..." }
                
                runningCounter = 0
                fullCount = WortFormenDictionary.keys.count
                for theWortFormKey in WortFormenDictionary.keys{
                    let theWortForm = WortFormenDictionary[theWortFormKey]!
                    if(!WortFormen.isComplete(theWortForm)){
                        theWortForm.successCounter = max(2, theWortForm.successCounter)
                    }
                    runningCounter += 1
                    Task { @MainActor in progress.fraction = Double(runningCounter)/Double(fullCount) }
                }
                
                Task { @MainActor in progress.text = "Обновление базы слов...\nИмпорт: склонения… ЗАВЕРШЕНО\nИмпорт: рода...ЗАВЕРШЕНО\nИмпорт: Падежи...ЗАВЕРШЕНО\nИмпорт: Сравнительные степени...ЗАВЕРШЕНО\nИмпорт: Модальность...ЗАВЕРШЕНО\nИмпорт: Числа...ЗАВЕРШЕНО\nИмпорт: Лица...ЗАВЕРШЕНО\nИмпорт: Времена...ЗАВЕРШЕНО\nИмпорт: Слова...ЗАВЕРШЕНО\nИмпорт: Формы слов...ЗАВЕРШЕНО\nИмпорт: Изменения слов...ЗАВЕРШЕНО\nИмпорт: Примеры...ЗАВЕРШЕНО\nПересчёт заученного...ЗАВЕРШЕНО"
                    progress.completed = true}
                
                Settings.setLastLoadedVersion(presetVersion, in: theContext)
            }else{
                
            }
        }catch{
            return
        }
    }
}
