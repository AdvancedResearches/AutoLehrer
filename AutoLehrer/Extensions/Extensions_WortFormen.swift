import CoreData

public struct WortArtFormen{
    var genus: Genus?
    var kasus: Kasus?
    var modus: Modus?
    var numerus: Numerus?
    var person: Person?
    var tempus: Tempus?
}

extension WortFormen{
    
    public static func get_wortFormenList_furArt(_ wortArt: WortArt) -> [WortArtFormen]{
        guard let context = wortArt.managedObjectContext else {
            return []
        }
        var retValue: [WortArtFormen] = []
        if(wortArt.name_DE == "Nomen"){
            for theNumerus in try! context.fetch(Numerus.fetchRequest()).sorted{$0.order < $1.order}{
                for theKasus in try! context.fetch(Kasus.fetchRequest()).sorted{$0.order < $1.order}{
                    retValue.append(WortArtFormen(kasus: theKasus, numerus: theNumerus))
                }
            }
        }
        if(wortArt.name_DE == "Verb"){
            for theModus in try! context.fetch(Modus.fetchRequest()).sorted{$0.order < $1.order}{
                for theTempus in try! context.fetch(Tempus.fetchRequest()).sorted{$0.order < $1.order}{
                    for theNumerus in try! context.fetch(Numerus.fetchRequest()).sorted{$0.order < $1.order}{
                        for thePerson in try! context.fetch(Person.fetchRequest()).sorted{$0.order < $1.order}{
                            retValue.append(WortArtFormen(modus: theModus, numerus: theNumerus, person: thePerson, tempus: theTempus))
                        }
                    }
                }
            }
        }
        if(wortArt.name_DE == "Adjektiv"){
        }
        if(wortArt.name_DE == "FunktionalWort"){
        }
        if(wortArt.name_DE == "Phrase"){
        }
        return retValue
    }
    public static func set_attempted(_ wortFormen: WortFormen){
        wortFormen.attempted = true
    }
    public static func coolDown(_ context: NSManagedObjectContext, _ wortArt: WortArt){
        let hotWortFormen: [WortFormen] = try! context.fetch(WortFormen.fetchRequest()).filter{$0.coolDown > 0 && $0.relWortArt == wortArt}
        for theFormen in hotWortFormen{
            theFormen.coolDown -= 1
        }
        try! context.save()
    }
    public static func get_failedCool(_ context: NSManagedObjectContext, _ wortArt: WortArt) -> [WortFormen]{
        return try! context.fetch(WortFormen.fetchRequest()).filter{$0.coolDown == 0 && $0.failed && $0.relWortArt == wortArt}.sorted{$0.wortFrequencyOrder < $1.wortFrequencyOrder}
    }
    public static func get_successfulCoolTop(_ context: NSManagedObjectContext, _ wortArt: WortArt) -> [WortFormen]{
        let result = try! context.fetch(WortFormen.fetchRequest())
            .filter { $0.coolDown == 0 && !$0.failed && $0.successCounter < 3  && $0.relWortArt == wortArt}
            .sorted { $0.wortFrequencyOrder < $1.wortFrequencyOrder }
            .prefix(20) // ← вот оно
        let top20 = Array(result)
        return top20
    }
    public static func get_successfulCoolRest(_ context: NSManagedObjectContext, _ wortArt: WortArt) -> [WortFormen]{
        let result = try! context.fetch(WortFormen.fetchRequest())
            .filter { $0.coolDown == 0 && !$0.failed && $0.successCounter < 3  && $0.relWortArt == wortArt}
            .sorted { $0.wortFrequencyOrder < $1.wortFrequencyOrder }
            .dropFirst(20)

        let rest = Array(result)
        
        let allTheRest = try! context.fetch(WortFormen.fetchRequest()).filter{$0.coolDown == 0 && !$0.failed && $0.successCounter >= 3  && $0.relWortArt == wortArt}.sorted{$0.wortFrequencyOrder < $1.wortFrequencyOrder}
        
        return rest + allTheRest
    }
    public static func get_failedHot(_ context: NSManagedObjectContext, _ wortArt: WortArt) -> [WortFormen]{
        return try! context.fetch(WortFormen.fetchRequest()).filter{$0.coolDown > 0 && $0.failed && $0.relWortArt == wortArt}.sorted{$0.wortFrequencyOrder < $1.wortFrequencyOrder}
    }
    public static func get_successfulHot(_ context: NSManagedObjectContext, _ wortArt: WortArt) -> [WortFormen]{
        return try! context.fetch(WortFormen.fetchRequest()).filter{$0.coolDown > 0 && !$0.failed && $0.relWortArt == wortArt}.sorted{$0.wortFrequencyOrder < $1.wortFrequencyOrder}
    }
    public static func set_success(_ wortFormen: WortFormen) -> Bool{
        guard let context = wortFormen.managedObjectContext else { return false }
        wortFormen.successCounter += 1
        wortFormen.coolDown = 20
        wortFormen.failed = false
        let formsAvailable = wortFormen.relWort?.count ?? 0
        if(wortFormen.successCounter >= 3){
            if(wortFormen.formsToShow < formsAvailable){
                wortFormen.formsToShow += 1
                wortFormen.successCounter = 0
                wortFormen.coolDown = 5
            }
        }
        try! context.save()
        return wortFormen.successCounter >= 3
    }
    public static func set_failure(_ wortFormen: WortFormen){
        guard let context = wortFormen.managedObjectContext else { return }
        wortFormen.successCounter = 0
        wortFormen.coolDown = 20
        wortFormen.failed = true
        try! context.save()
    }
    public static func get_wortArt_string(_ wortFormen: WortFormen) -> String{
        if(wortFormen.relWortArt != nil){
            return wortFormen.relWortArt!.name_DE ?? ""
        }
        return ""
    }
}
