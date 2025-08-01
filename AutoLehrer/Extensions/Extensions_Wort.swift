import CoreData

extension Wort{
    public static func pick_wort(_ wortForm: WortFormen, genus: Genus?, kasus: Kasus?, modus: Modus?, numerus: Numerus?, person: Person?, tempus: Tempus?) -> Wort?{
        guard let context = wortForm.managedObjectContext else {
            return nil
        }
        var filteredWorten: [Wort] = try! context.fetch(Wort.fetchRequest()).filter{$0.relWortFormen == wortForm}
        if(genus != nil){
            filteredWorten = filteredWorten.filter{$0.relGenus == genus!}
        }
        if(kasus != nil){
            filteredWorten = filteredWorten.filter{$0.relKasus == kasus!}
        }
        if(modus != nil){
            filteredWorten = filteredWorten.filter{$0.relModus == modus!}
        }
        if(numerus != nil){
            filteredWorten = filteredWorten.filter{$0.relNumerus == numerus!}
        }
        if(person != nil){
            filteredWorten = filteredWorten.filter{$0.relPerson == person!}
        }
        if(tempus != nil){
            filteredWorten = filteredWorten.filter{$0.relTempus == tempus!}
        }
        return filteredWorten.first
    }
    /*
    public static func pick_nomenativ_singular(_ wortHive: WortHive) -> Wort?{
        let context = nomenHive.managedObjectContext!
        let kasus = try! context.fetch(Kasus.fetchRequest()).filter{$0.name_DE == "Nominativ"}.first!
        let numerus = try! context.fetch(Numerus.fetchRequest()).filter{$0.name_DE == "Singular"}.first!
        guard let nomenSet = nomenHive.relWort as? Set<Wort>,
              let match = nomenSet.first(where: { $0.relKasus == kasus && $0.relNumerus == numerus }) else {
            return nil
        }
        return match
    }
    public static func pick_genitiv_singular(_ wortHive: WortHive) -> Wort?{
        let context = nomenHive.managedObjectContext!
        let kasus = try! context.fetch(Kasus.fetchRequest()).filter{$0.name_DE == "Genitiv"}.first!
        let numerus = try! context.fetch(Numerus.fetchRequest()).filter{$0.name_DE == "Singular"}.first!
        guard let nomenSet = nomenHive.relNomen as? Set<Nomen>,
              let match = nomenSet.first(where: { $0.relKasus == kasus && $0.relNumerus == numerus }) else {
            return nil
        }
        return match
    }
    public static func pick_akkusativ_singular(_ wortHive: WortHive) -> Wort?{
        let context = nomenHive.managedObjectContext!
        let kasus = try! context.fetch(Kasus.fetchRequest()).filter{$0.name_DE == "Akkusativ"}.first!
        let numerus = try! context.fetch(Numerus.fetchRequest()).filter{$0.name_DE == "Singular"}.first!
        guard let nomenSet = nomenHive.relNomen as? Set<Nomen>,
              let match = nomenSet.first(where: { $0.relKasus == kasus && $0.relNumerus == numerus }) else {
            return nil
        }
        return match
    }
    public static func pick_dativ_singular(_ wortHive: WortHive) -> Wort?{
        let context = nomenHive.managedObjectContext!
        let kasus = try! context.fetch(Kasus.fetchRequest()).filter{$0.name_DE == "Dativ"}.first!
        let numerus = try! context.fetch(Numerus.fetchRequest()).filter{$0.name_DE == "Singular"}.first!
        guard let nomenSet = nomenHive.relNomen as? Set<Nomen>,
              let match = nomenSet.first(where: { $0.relKasus == kasus && $0.relNumerus == numerus }) else {
            return nil
        }
        return match
    }
    public static func pick_nomenativ_plural(_ wortHive: WortHive) -> Wort?{
        let context = nomenHive.managedObjectContext!
        let kasus = try! context.fetch(Kasus.fetchRequest()).filter{$0.name_DE == "Nominativ"}.first!
        let numerus = try! context.fetch(Numerus.fetchRequest()).filter{$0.name_DE == "Plural"}.first!
        guard let nomenSet = nomenHive.relNomen as? Set<Nomen>,
              let match = nomenSet.first(where: { $0.relKasus == kasus && $0.relNumerus == numerus }) else {
            return nil
        }
        return match
    }
    public static func pick_genitiv_plural(_ wortHive: WortHive) -> Wort?{
        let context = nomenHive.managedObjectContext!
        let kasus = try! context.fetch(Kasus.fetchRequest()).filter{$0.name_DE == "Genitiv"}.first!
        let numerus = try! context.fetch(Numerus.fetchRequest()).filter{$0.name_DE == "Plural"}.first!
        guard let nomenSet = nomenHive.relNomen as? Set<Nomen>,
              let match = nomenSet.first(where: { $0.relKasus == kasus && $0.relNumerus == numerus }) else {
            return nil
        }
        return match
    }
    public static func pick_akkusativ_plural(_ wortHive: WortHive) -> Wort?{
        let context = nomenHive.managedObjectContext!
        let kasus = try! context.fetch(Kasus.fetchRequest()).filter{$0.name_DE == "Akkusativ"}.first!
        let numerus = try! context.fetch(Numerus.fetchRequest()).filter{$0.name_DE == "Plural"}.first!
        guard let nomenSet = nomenHive.relNomen as? Set<Nomen>,
              let match = nomenSet.first(where: { $0.relKasus == kasus && $0.relNumerus == numerus }) else {
            return nil
        }
        return match
    }
    public static func pick_dativ_plural(_ wortHive: WortHive) -> Wort?{
        let context = nomenHive.managedObjectContext!
        let kasus = try! context.fetch(Kasus.fetchRequest()).filter{$0.name_DE == "Dativ"}.first!
        let numerus = try! context.fetch(Numerus.fetchRequest()).filter{$0.name_DE == "Plural"}.first!
        guard let nomenSet = nomenHive.relNomen as? Set<Nomen>,
              let match = nomenSet.first(where: { $0.relKasus == kasus && $0.relNumerus == numerus }) else {
            return nil
        }
        return match
    }
     */
    public static func get_beispiel(_ wort: Wort) -> Beispiel? {
        guard let beispielSet = wort.relBeispiel as? Set<Beispiel>, !beispielSet.isEmpty else {
            return nil
        }

        // Например, вернуть первый элемент (или можешь выбрать случайный, если хочешь)
        return beispielSet.randomElement()
    }
}
