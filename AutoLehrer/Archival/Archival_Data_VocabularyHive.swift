//
//  Archival_Time.swift
//  DerTermin
//
//  Created by Алексей Хурсевич on 14.02.24.
//

import Foundation
import CoreData

struct BeispielHive: Codable{
    var theHive: [BeispielItem]
}

struct BeispielItem: Codable{
    var beispiel_DE: String
    var beispiel_RU: String
    var relWort: String
    var beispielKey: String
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
    var wort_DE: String
    var wort_RU: String
    var relGenus: String?
    var relKasus: String?
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
    //var beispielHive: BeispielHive
    var genusHive: GenusHive
    var kasusHive: KasusHive
    var modusHive: ModusHive
    var numerusHive: NumerusHive
    var personHive: PersonHive
    var tempusHive: TempusHive
    //var wortHive: WortHive
    var wortArtHive: WortArtHive
    var wortFormenHive: WortFormenHive
}

struct Archival_Vocabulary{
    static func dump(theContext: NSManagedObjectContext) -> VocabularyHive{
        var retHive = VocabularyHive(
            //beispielHive: BeispielHive(theHive: []),
            genusHive: GenusHive(theHive: []),
            kasusHive: KasusHive(theHive: []),
            modusHive: ModusHive(theHive: []),
            numerusHive: NumerusHive(theHive: []),
            personHive: PersonHive(theHive: []),
            tempusHive: TempusHive(theHive: []),
            //wortHive: WortHive(theHive: []),
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
    
    static func preset_1_0_0_0(theContext: NSManagedObjectContext, theData: VocabularyHive){
        do{
            //flush
            flush(theContext: theContext, totalFlush: false)
            
            var GenusDictionary: [String:Genus] = [:]
            for theGenus in theData.genusHive.theHive{
                let uploadingGenus = Genus(context: theContext)
                uploadingGenus.name_DE = theGenus.name_DE
                uploadingGenus.name_RU = theGenus.name_RU
                uploadingGenus.order = theGenus.order
                GenusDictionary.updateValue(uploadingGenus, forKey: theGenus.genusKey)
            }
            
            var KasusDictionary: [String:Kasus] = [:]
            for theKasus in theData.kasusHive.theHive{
                let uploadingKasus = Kasus(context: theContext)
                uploadingKasus.name_DE = theKasus.name_DE
                uploadingKasus.name_RU = theKasus.name_RU
                uploadingKasus.fragen_DE = theKasus.fragen_DE
                uploadingKasus.fragen_RU = theKasus.fragen_RU
                uploadingKasus.order = theKasus.order
                KasusDictionary.updateValue(uploadingKasus, forKey: theKasus.kasusKey)
            }
            
            var ModusDictionary: [String:Modus] = [:]
            for theModus in theData.modusHive.theHive{
                let uploadingModus = Modus(context: theContext)
                uploadingModus.name_DE = theModus.name_DE
                uploadingModus.name_RU = theModus.name_RU
                uploadingModus.order = theModus.order
                ModusDictionary.updateValue(uploadingModus, forKey: theModus.modusKey)
            }
            
            var NumerusDictionary: [String:Numerus] = [:]
            for theNumerus in theData.numerusHive.theHive{
                let uploadingNumerus = Numerus(context: theContext)
                uploadingNumerus.name_DE = theNumerus.name_DE
                uploadingNumerus.name_RU = theNumerus.name_RU
                uploadingNumerus.order = theNumerus.order
                NumerusDictionary.updateValue(uploadingNumerus, forKey: theNumerus.numerusKey)
            }
            
            var PersonDictionary: [String:Person] = [:]
            for thePerson in theData.personHive.theHive{
                let uploadingPerson = Person(context: theContext)
                uploadingPerson.name_DE = thePerson.name_DE
                uploadingPerson.name_RU = thePerson.name_RU
                uploadingPerson.order = thePerson.order
                PersonDictionary.updateValue(uploadingPerson, forKey: thePerson.personKey)
            }
            
            var TempusDictionary: [String:Tempus] = [:]
            for theTempus in theData.tempusHive.theHive{
                let uploadingTempus = Tempus(context: theContext)
                uploadingTempus.name_DE = theTempus.name_DE
                uploadingTempus.name_RU = theTempus.name_RU
                uploadingTempus.order = theTempus.order
                TempusDictionary.updateValue(uploadingTempus, forKey: theTempus.tempusKey)
            }
            
            var WortArtDictionary: [String:WortArt] = [:]
            for theWortArt in theData.wortArtHive.theHive{
                let uploadingWortArt = WortArt(context: theContext)
                uploadingWortArt.name_DE = theWortArt.name_DE
                uploadingWortArt.name_RU = theWortArt.name_RU
                WortArtDictionary.updateValue(uploadingWortArt, forKey: theWortArt.wortArtKey)
            }
            
            var WortFormenDictionary: [String:WortFormen] = [:]
            for theWortFormen in theData.wortFormenHive.theHive{
                let uploadingWortFormen = WortFormen(context: theContext)
                uploadingWortFormen.wortFrequencyOrder = theWortFormen.wortFrequencyOrder
                uploadingWortFormen.relWortArt    = WortArtDictionary[theWortFormen.relWortArt]!
                WortFormenDictionary.updateValue(uploadingWortFormen, forKey: theWortFormen.wortFormenKey)
            }
            /*
            var WortDictionary: [String:Wort] = [:]
            for theWort in theData.wortHive.theHive{
                let uploadingWort = Wort(context: theContext)
                uploadingWort.wort_DE = theWort.wort_DE
                uploadingWort.wort_RU = theWort.wort_RU

                uploadingWort.relGenus      = GenusDictionary[theWort.relGenus ?? "NIL"]
                uploadingWort.relKasus      = KasusDictionary[theWort.relKasus ?? "NIL"]
                uploadingWort.relModus      = ModusDictionary[theWort.relModus ?? "NIL"]
                uploadingWort.relNumerus    = NumerusDictionary[theWort.relNumerus ?? "NIL"]
                uploadingWort.relPerson     = PersonDictionary[theWort.relPerson ?? "NIL"]
                uploadingWort.relTempus     = TempusDictionary[theWort.relTempus ?? "NIL"]
                
                uploadingWort.relWortFormen = WortFormenDictionary[theWort.relWortFormen]!
                WortDictionary.updateValue(uploadingWort, forKey: theWort.wortKey)
            }
            
            var BeispielDictionary: [String:Beispiel] = [:]
            for theBeispel in theData.beispielHive.theHive{
                let uploadingBeispiel = Beispiel(context: theContext)
                uploadingBeispiel.beispiel_DE = theBeispel.beispiel_DE
                uploadingBeispiel.beispiel_RU = theBeispel.beispiel_RU
                uploadingBeispiel.relWort = WortDictionary[theBeispel.relWort]
                BeispielDictionary.updateValue(uploadingBeispiel, forKey: theBeispel.beispielKey)
            }
             */
        }catch{
            return
        }
    }
}
