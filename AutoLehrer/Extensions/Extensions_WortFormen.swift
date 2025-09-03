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
    public static let treatedAsRandomFailCount: Int = 6
    public static func get_success_delay_inSeconds(successCount: Int) -> Int{
        if(successCount <= 1){
            return 60
        }
        if(successCount == 2){
            return 180
        }
        if(successCount == 3){
            return 600
        }
        if(successCount == 4){
            return 3600
        }
        if(successCount == 5){
            return 21600
        }
        return Int.random(in: 86400...259200)
    }
    public static func get_fail_delay_inSeconds(failCount: Int, failLevel: Int, isRandomFail: Bool) -> Int{
        if(isRandomFail){
            return 60
        }
        if(failLevel==0){
            if(failCount <= 1){
                return 60
            }
            if(failCount == 2){
                return 60
            }
            if(failCount == 3){
                return 180
            }
            if(failCount == 4){
                return 60
            }
            if(failCount == 5){
                return Int.random(in: 3600...86400)
            }
            return Int.random(in: 0...604800)
        }
        if(failLevel==1){
            if(failCount <= 1){
                return 60
            }
            if(failCount == 2){
                return 60
            }
            if(failCount == 3){
                return 180
            }
            if(failCount == 4){
                return 60
            }
            if(failCount == 5){
                return Int.random(in: 3600...86400)
            }
            return Int.random(in: 0...604800)
        }
        if(failLevel==2){
            if(failCount <= 1){
                return 60
            }
            if(failCount == 2){
                return 60
            }
            if(failCount == 3){
                return 180
            }
            if(failCount == 4){
                return 60
            }
            if(failCount == 5){
                return Int.random(in: 3600...86400)
            }
            return Int.random(in: 0...604800)
        }
        if(failCount <= 1){
            return 60
        }
        if(failCount == 2){
            return 60
        }
        if(failCount == 3){
            return 180
        }
        if(failCount == 4){
            return 60
        }
        if(failCount == 5){
            return Int.random(in: 3600...86400)
        }
        return Int.random(in: 0...604800)
    }
    public static func set_success(_ wortFormen: WortFormen, attemptedFormen: [Wort]) -> Bool{
        guard let context = wortFormen.managedObjectContext else { return false }
        
        wortFormen.formsToShow = Int64(attemptedFormen.count)
        //print("Wort zahlung: WortFormen.set_success. Set formsToShow to \(wortFormen.formsToShow)")
        
        let maxLevel = attemptedFormen.map { $0.level ?? 0 }.max() ?? 0
        wortFormen.levelReached = maxLevel
        
        wortFormen.attempted = true
        
        if wortFormen.failed{
            wortFormen.coolDown = WortFormen.successCoolDown
            wortFormen.successCounter = 1
        }else{
            wortFormen.successCounter += 1
            if(wortFormen.formsToShow == WortFormen.alleFormenZahlung(wortFormen)){
                wortFormen.coolDown = WortFormen.completeCoolDown
            }else{
                wortFormen.coolDown = WortFormen.successCoolDownFastTrack
            }
        }
        
        wortFormen.nextPlanedAttempt = Date.now.offset_inSeconds(get_success_delay_inSeconds(successCount: Int(wortFormen.successCounter)))
        
        wortFormen.failCounter = 0
        wortFormen.failed = false
        
        print("set_success: nextPlannedAttempt set to \(wortFormen.nextPlanedAttempt)")
        
        try! context.save()
        
        let allAvailable = Int64((wortFormen.relWort as? Set<Wort>)?.count ?? 0)
        
        return wortFormen.formsToShow == allAvailable
    }
    public static func set_failure(_ wortFormen: WortFormen, attemptedFormen: [Wort], failLevel: Int){
        guard let context = wortFormen.managedObjectContext else { return }
        
        let isRandomFailure = wortFormen.randomFail ? false : wortFormen.successCounter >= treatedAsRandomFailCount
        
        if(isRandomFailure){
            wortFormen.nextPlanedAttempt =  Date.now.offset_inSeconds(get_fail_delay_inSeconds(failCount: 0, failLevel: 0, isRandomFail: true))
            wortFormen.randomFail = true
        }else{
            if(wortFormen.failed){
                wortFormen.failCounter += 1
            }else{
                wortFormen.failCounter = 1
            }
            wortFormen.successCounter = 0
            wortFormen.coolDown = WortFormen.failCoolDown
            wortFormen.failed = true
            
            let maxLevel = attemptedFormen.map { $0.level ?? 0 }.max() ?? 0
            wortFormen.levelReached = maxLevel
            
            wortFormen.nextPlanedAttempt =  Date.now.offset_inSeconds(get_fail_delay_inSeconds(failCount: 0, failLevel: 0, isRandomFail: true))
            
            wortFormen.randomFail = false
        }
        
        wortFormen.formsToShow = Int64(attemptedFormen.count)
        wortFormen.attempted = true
        
        print("set_failure: nextPlannedAttempt set to \(wortFormen.nextPlanedAttempt)")
        
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
    public static func attemptingFormenRatio(_ wortFormen: WortFormen, fasttrackExtras: Int) -> Double{
        let alleFormen: Double = Double(alleFormenZahlung(wortFormen))
        let succeededFormen: Double = Double(wortFormen.formsToShow)
        return alleFormen > 0 ? (succeededFormen / alleFormen) : 0
    }
    public static func succeededFormenRatio(_ wortFormen: WortFormen) -> Double{
        let alleFormen: Double = Double(alleFormenZahlung(wortFormen))
        let succeededFormen: Double = Double(wortFormen.lastSucceeded)
        return alleFormen > 0 ? (succeededFormen / alleFormen) : 0
    }
    public static func alleFormenZahlung(_ wortFormen: WortFormen) -> Int{
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
        
        retValue = Array(sortedWorte.prefix(countToRetrive))
        
        return retValue
    }
    public static func retrieve_alleFormen(_ wortFormen: WortFormen) -> [Wort] {
        var retValue: [Wort] = []
        
        var alleWorteFurSache = wortFormen.relWort?.allObjects as! [Wort] ?? []
        var sortedWorte = Wort.Worte_sort(alleWorteFurSache, wortFormen.relWortArt!)
        
        return sortedWorte
    }
}
