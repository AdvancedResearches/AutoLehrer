import CoreData

public struct WortSorting{
    var deklinationOrder: Int
    var genusOrder: Int
    var hoflichkeitenOrder: Int
    var kasusOrder: Int
    var komparationsgradOrder: Int
    var modusOrder: Int
    var numerusOrder: Int
    var personOrder: Int
    var pronomenartOrder: Int
    var tempusOrder: Int
    var dasWort: Wort
    public static func fromWort(_ wort: Wort) -> WortSorting {
        return WortSorting(
            deklinationOrder: Int(wort.relDeklination?.order ?? 1000),
            genusOrder: Int(wort.relGenus?.order ?? 10000),
            hoflichkeitenOrder: Int(wort.relHoflichkeiten?.order ?? 1000),
            kasusOrder: Int(wort.relKasus?.order ?? 10000),
            komparationsgradOrder: Int(wort.relKomparationsgrad?.order ?? 1000),
            modusOrder: Int(wort.relModus?.order ?? 1000),
            numerusOrder: Int(wort.relNumerus?.order ?? 1000),
            personOrder: Int(wort.relPerson?.order ?? 1000),
            pronomenartOrder: Int(wort.relPronomenart?.order ?? 1000),
            tempusOrder: Int(wort.relTempus?.order ?? 1000),
            dasWort: wort
        )
    }
    public static func fromWortArray(_ worte: [Wort]) -> [WortSorting] {
        var retValue: [WortSorting] = []
        for theCounter in 0..<worte.count {
            retValue.append(WortSorting.fromWort(worte[theCounter]))
        }
        return retValue
    }
}

public struct WortArtFormen{
    var deklination: Deklination?
    var genus: Genus?
    var hoflichkeiten: Hoflichkeiten?
    var kasus: Kasus?
    var komparationsgrad: Komparationsgrad?
    var modus: Modus?
    var numerus: Numerus?
    var person: Person?
    var pronomenart: Pronomenart?
    var tempus: Tempus?
    public static func fromWort(_ wort: Wort) -> WortArtFormen {
        return WortArtFormen(
            deklination: wort.relDeklination,
            genus: wort.relGenus,
            hoflichkeiten: wort.relHoflichkeiten,
            kasus: wort.relKasus,
            komparationsgrad: wort.relKomparationsgrad,
            modus: wort.relModus,
            numerus: wort.relNumerus,
            person: wort.relPerson,
            pronomenart: wort.relPronomenart,
            tempus: wort.relTempus
        )
    }
    public func debug_string() -> String{
        var retValue = ""
        if deklination != nil {
            retValue += "deklination=\(deklination!.name_DE!);"
        }
        if genus != nil {
            retValue += "genus=\(genus!.name_DE!);"
        }
        if hoflichkeiten != nil {
            retValue += "hoflichkeiten=\(hoflichkeiten!.name_DE!);"
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
        if pronomenart != nil {
            retValue += "pronomenart=\(pronomenart!.name_DE!);"
        }
        if tempus != nil {
            retValue += "tempus=\(tempus!.name_DE!);"
        }
        return retValue
    }
}

extension WortFormen{
    public static let completeCoolDown: Int64 = 51
    public static let successCoolDown: Int64 = 21
    public static let successCoolDownFastTrack: Int64 = 2
    public static let failCoolDown: Int64 = 11
    public static let failCoolDownFastTrack: Int64 = 11
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
                for theGenus in try! context.fetch(Genus.fetchRequest()).sorted{$0.order < $1.order}{
                    for theNumerus in try! context.fetch(Numerus.fetchRequest()).sorted{$0.order < $1.order}{
                        for theHoflichkeit in try! context.fetch(Hoflichkeiten.fetchRequest()).sorted{$0.order < $1.order}{
                            for thePerson in try! context.fetch(Person.fetchRequest()).sorted{$0.order < $1.order}{
                                for thePronomenart in try! context.fetch(Pronomenart.fetchRequest()).sorted{$0.order < $1.order}{
                                    for theKasus in try! context.fetch(Kasus.fetchRequest()).sorted{$0.order < $1.order}{
                                        retValue.append(WortArtFormen(deklination: theDeklination, genus: theGenus, hoflichkeiten: theHoflichkeit, kasus: theKasus, numerus: theNumerus, person: thePerson, pronomenart: thePronomenart))
                                    }
                                }
                            }
                        }
                    }
                }
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
    public static func get_failedHot_notRecent3(_ context: NSManagedObjectContext, _ wortArt: WortArt) -> [WortFormen]{
        return try! context.fetch(WortFormen.fetchRequest()).filter{$0.coolDown > 0 && $0.coolDown < (WortFormen.failCoolDown - 3) && $0.failed && $0.relWortArt == wortArt}.sorted{$0.wortFrequencyOrder < $1.wortFrequencyOrder}
    }
    public static func get_successfulHot_notRecent3(_ context: NSManagedObjectContext, _ wortArt: WortArt) -> [WortFormen]{
        return try! context.fetch(WortFormen.fetchRequest()).filter{$0.coolDown > 0 && $0.coolDown < (WortFormen.successCoolDown - 3) && !$0.failed && $0.relWortArt == wortArt}.sorted{$0.wortFrequencyOrder < $1.wortFrequencyOrder}
    }
    public static func get_failedHot_recent3(_ context: NSManagedObjectContext, _ wortArt: WortArt) -> [WortFormen]{
        return try! context.fetch(WortFormen.fetchRequest()).filter{$0.coolDown > 0 && $0.coolDown >= (WortFormen.failCoolDown - 3) && $0.failed && $0.relWortArt == wortArt}.sorted{$0.wortFrequencyOrder < $1.wortFrequencyOrder}
    }
    public static func get_successfulHot_recent3(_ context: NSManagedObjectContext, _ wortArt: WortArt) -> [WortFormen]{
        return try! context.fetch(WortFormen.fetchRequest()).filter{$0.coolDown > 0 && $0.coolDown >= (WortFormen.successCoolDown - 3) && !$0.failed && $0.relWortArt == wortArt}.sorted{$0.wortFrequencyOrder < $1.wortFrequencyOrder}
    }
    public static func set_success(_ wortFormen: WortFormen) -> Bool{
        guard let context = wortFormen.managedObjectContext else { return false }
        let shallAddNewForm = shallAddNewForm(wortFormen)
        wortFormen.successCounter += 1
        
        if wortFormen.failed{
            wortFormen.coolDown = WortFormen.successCoolDown
        }else{
            if(wortFormen.formsToShow == WortFormen.alleFormen(wortFormen)){
                wortFormen.coolDown = WortFormen.completeCoolDown
            }else{
                wortFormen.coolDown = WortFormen.successCoolDownFastTrack
            }
        }
        
        if shallAddNewForm{
                wortFormen.formsToShow += 1
                wortFormen.successCounter = 0
                
        }else{
            if(wortConfirmed(wortFormen)){
                wortFormen.successCounter = 3
            }
        }
        
        wortFormen.failed = false
        try! context.save()
        return wortFormen.successCounter >= 3
    }
    public static func set_failure(_ wortFormen: WortFormen){
        guard let context = wortFormen.managedObjectContext else { return }
        wortFormen.successCounter = 0
        wortFormen.coolDown = WortFormen.failCoolDown
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
    public static func attemptingFormenRatio(_ wortFormen: WortFormen) -> Double{
        let alleFormen: Double = Double(alleFormen(wortFormen))
        return (Double(wortFormen.formsToShow) / alleFormen)
    }
    public static func succeededFormenRatio(_ wortFormen: WortFormen) -> Double{
        let alleFormen: Double = Double(alleFormen(wortFormen))
        return (Double(wortFormen.formsToShow<=0 ? 0 : wortFormen.formsToShow-1) / alleFormen)
    }
    public static func alleFormen(_ wortFormen: WortFormen) -> Int{
        return wortFormen.relWort?.count ?? 0
    }
    public static func repetitionsToAddNewForm(_ wortFormen: WortFormen) -> Int{
        if wortFormen.failed{
            return Int(2 - wortFormen.successCounter)
        }else{
            return 0
        }
    }
    public static func shallAddNewForm(_ wortFormen: WortFormen) -> Bool{
        if(repetitionsToAddNewForm(wortFormen) <= 0){
            if(wortFormen.formsToShow < wortFormen.relWort?.count ?? 0){
                return true
            }
        }
        return false
    }
    public static func wortConfirmed(_ wortFormen: WortFormen) -> Bool{
        if(repetitionsToAddNewForm(wortFormen) <= 0){
            if(wortFormen.formsToShow >= wortFormen.relWort?.count ?? 0){
                return true
            }
        }
        return false
    }
    public static func retrieve_allAllowedFormen(_ wortFormen: WortFormen, includeLastAttempting: Bool = true) -> [Wort] {
        var retValue: [Wort] = []
        
        var alleWorteFurSache = wortFormen.relWort?.allObjects as! [Wort] ?? []
        var sortedWorte = Wort.Worte_sort(alleWorteFurSache, wortFormen.relWortArt!)
        
        var countToRetrive: Int = Int(wortFormen.formsToShow)
        
        if(!includeLastAttempting){
            if(wortFormen.successCounter < 2){
                countToRetrive -= 1
            }
        }
        
        retValue = Array(sortedWorte.prefix(Int(wortFormen.formsToShow)))
        
        return retValue
    }
}
