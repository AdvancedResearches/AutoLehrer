import CoreData

public struct WortArtFormen{
    var deklination: Deklination?
    var genus: Genus?
    var kasus: Kasus?
    var komparationsgrad: Komparationsgrad?
    var modus: Modus?
    var numerus: Numerus?
    var person: Person?
    var tempus: Tempus?
    public func debug_string() -> String{
        var retValue = ""
        if deklination != nil {
            retValue += "deklination=\(deklination!.name_DE!);"
        }
        if genus != nil {
            retValue += "genus=\(genus!.name_DE!);"
        }
        if kasus != nil {
            retValue += "kasus=\(kasus!.name_DE!);"
        }
        if komparationsgrad != nil {
            retValue += "komparationsgrad=\(komparationsgrad!.name_DE!);"
        }
        if modus != nil {
            retValue += "modus=\(modus!.name_DE!);"
        }
        if numerus != nil {
            retValue += "numerus=\(numerus!.name_DE!);"
        }
        if person != nil {
            retValue += "person=\(person!.name_DE!);"
        }
        if tempus != nil {
            retValue += "tempus=\(tempus!.name_DE!);"
        }
        return retValue
    }
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
        if(wortArt.name_DE == "Adjective"){
            for theDeklination in try! context.fetch(Deklination.fetchRequest()).sorted{$0.order < $1.order}{
                if(theDeklination.name_DE == "Grundform"){
                    retValue.append(WortArtFormen(deklination: theDeklination))
                }else{
                    for theGenus in try! context.fetch(Genus.fetchRequest()).sorted{$0.order < $1.order}{
                        for theNumerus in try! context.fetch(Numerus.fetchRequest()).sorted{$0.order < $1.order}{
                            for theKomparisongrad in try! context.fetch(Komparationsgrad.fetchRequest()).sorted{$0.order < $1.order}{
                                for theKasus in try! context.fetch(Kasus.fetchRequest()).sorted{$0.order < $1.order}{
                                    retValue.append(WortArtFormen(deklination: theDeklination, genus: theGenus, kasus: theKasus, komparationsgrad: theKomparisongrad, numerus: theNumerus))
                                }
                            }
                        }
                    }
                }
            }
        }
        if(wortArt.name_DE == "Funktional Wort"){
            for theDeklination in try! context.fetch(Deklination.fetchRequest()).sorted{$0.order < $1.order}{
                retValue.append(WortArtFormen(deklination: theDeklination))
            }
        }
        if(wortArt.name_DE == "Phrase"){
            for theDeklination in try! context.fetch(Deklination.fetchRequest()).sorted{$0.order < $1.order}{
                retValue.append(WortArtFormen(deklination: theDeklination))
            }
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
        let formsAvailable = wortFormen.relWort?.count ?? 0
        if wortFormen.failed{
            if(wortFormen.successCounter >= 3){
                if(wortFormen.formsToShow < formsAvailable){
                    wortFormen.formsToShow += 1
                    wortFormen.successCounter = 0
                    wortFormen.coolDown = 5
                }
            }
        }else{
            if(wortFormen.successCounter == 1){
                if(wortFormen.formsToShow < formsAvailable){
                    wortFormen.formsToShow += 1
                    wortFormen.successCounter = 0
                    wortFormen.coolDown = 5
                }
            }else{
                if(wortFormen.successCounter >= 3){
                    if(wortFormen.formsToShow < formsAvailable){
                        wortFormen.formsToShow += 1
                        wortFormen.successCounter = 0
                        wortFormen.coolDown = 5
                    }
                }
            }
        }
        wortFormen.failed = false
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
    public static func findOrCreate(in context: NSManagedObjectContext, wortArt: WortArt?, order: Int64) -> WortFormen {
        var result: WortFormen? = nil
        do{
            if(wortArt != nil){
                result = try context.fetch(WortFormen.fetchRequest()).filter{$0.relWortArt == wortArt && $0.wortFrequencyOrder == order}.first
            }
            if result == nil {
                result = WortFormen(context: context)
            }
        }catch{}
        return result!
    }
    public static func isComplete(_ wortFormen: WortFormen) -> Bool{
        let alleWorteCount = wortFormen.relWort?.allObjects.count ?? 0
        let successCounter = wortFormen.successCounter
        let formenZuzeigen = wortFormen.formsToShow
        if(successCounter > 2){
            if(formenZuzeigen >= alleWorteCount){
                return true
            }
        }
        return false
    }
}
