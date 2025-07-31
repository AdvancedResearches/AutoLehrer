import CoreData

extension Nomen{
    public static func pick_nomenativ_singular(_ nomenHive: NomenHive) -> Nomen?{
        let context = nomenHive.managedObjectContext!
        let kasus = try! context.fetch(Kasus.fetchRequest()).filter{$0.name_DE == "Nominativ"}.first!
        let numerus = try! context.fetch(Numerus.fetchRequest()).filter{$0.name_DE == "Singular"}.first!
        guard let nomenSet = nomenHive.relNomen as? Set<Nomen>,
              let match = nomenSet.first(where: { $0.relKasus == kasus && $0.relNumerus == numerus }) else {
            return nil
        }
        return match
    }
    public static func pick_genitiv_singular(_ nomenHive: NomenHive) -> Nomen?{
        let context = nomenHive.managedObjectContext!
        let kasus = try! context.fetch(Kasus.fetchRequest()).filter{$0.name_DE == "Genitiv"}.first!
        let numerus = try! context.fetch(Numerus.fetchRequest()).filter{$0.name_DE == "Singular"}.first!
        guard let nomenSet = nomenHive.relNomen as? Set<Nomen>,
              let match = nomenSet.first(where: { $0.relKasus == kasus && $0.relNumerus == numerus }) else {
            return nil
        }
        return match
    }
    public static func pick_akkusativ_singular(_ nomenHive: NomenHive) -> Nomen?{
        let context = nomenHive.managedObjectContext!
        let kasus = try! context.fetch(Kasus.fetchRequest()).filter{$0.name_DE == "Akkusativ"}.first!
        let numerus = try! context.fetch(Numerus.fetchRequest()).filter{$0.name_DE == "Singular"}.first!
        guard let nomenSet = nomenHive.relNomen as? Set<Nomen>,
              let match = nomenSet.first(where: { $0.relKasus == kasus && $0.relNumerus == numerus }) else {
            return nil
        }
        return match
    }
    public static func pick_dativ_singular(_ nomenHive: NomenHive) -> Nomen?{
        let context = nomenHive.managedObjectContext!
        let kasus = try! context.fetch(Kasus.fetchRequest()).filter{$0.name_DE == "Dativ"}.first!
        let numerus = try! context.fetch(Numerus.fetchRequest()).filter{$0.name_DE == "Singular"}.first!
        guard let nomenSet = nomenHive.relNomen as? Set<Nomen>,
              let match = nomenSet.first(where: { $0.relKasus == kasus && $0.relNumerus == numerus }) else {
            return nil
        }
        return match
    }
    public static func pick_nomenativ_plural(_ nomenHive: NomenHive) -> Nomen?{
        let context = nomenHive.managedObjectContext!
        let kasus = try! context.fetch(Kasus.fetchRequest()).filter{$0.name_DE == "Nominativ"}.first!
        let numerus = try! context.fetch(Numerus.fetchRequest()).filter{$0.name_DE == "Plural"}.first!
        guard let nomenSet = nomenHive.relNomen as? Set<Nomen>,
              let match = nomenSet.first(where: { $0.relKasus == kasus && $0.relNumerus == numerus }) else {
            return nil
        }
        return match
    }
    public static func pick_genitiv_plural(_ nomenHive: NomenHive) -> Nomen?{
        let context = nomenHive.managedObjectContext!
        let kasus = try! context.fetch(Kasus.fetchRequest()).filter{$0.name_DE == "Genitiv"}.first!
        let numerus = try! context.fetch(Numerus.fetchRequest()).filter{$0.name_DE == "Plural"}.first!
        guard let nomenSet = nomenHive.relNomen as? Set<Nomen>,
              let match = nomenSet.first(where: { $0.relKasus == kasus && $0.relNumerus == numerus }) else {
            return nil
        }
        return match
    }
    public static func pick_akkusativ_plural(_ nomenHive: NomenHive) -> Nomen?{
        let context = nomenHive.managedObjectContext!
        let kasus = try! context.fetch(Kasus.fetchRequest()).filter{$0.name_DE == "Akkusativ"}.first!
        let numerus = try! context.fetch(Numerus.fetchRequest()).filter{$0.name_DE == "Plural"}.first!
        guard let nomenSet = nomenHive.relNomen as? Set<Nomen>,
              let match = nomenSet.first(where: { $0.relKasus == kasus && $0.relNumerus == numerus }) else {
            return nil
        }
        return match
    }
    public static func pick_dativ_plural(_ nomenHive: NomenHive) -> Nomen?{
        let context = nomenHive.managedObjectContext!
        let kasus = try! context.fetch(Kasus.fetchRequest()).filter{$0.name_DE == "Dativ"}.first!
        let numerus = try! context.fetch(Numerus.fetchRequest()).filter{$0.name_DE == "Plural"}.first!
        guard let nomenSet = nomenHive.relNomen as? Set<Nomen>,
              let match = nomenSet.first(where: { $0.relKasus == kasus && $0.relNumerus == numerus }) else {
            return nil
        }
        return match
    }
    public static func get_beispiel(_ nomen: Nomen) -> Beispiel? {
        guard let beispielSet = nomen.relBeispiel as? Set<Beispiel>, !beispielSet.isEmpty else {
            return nil
        }

        // Например, вернуть первый элемент (или можешь выбрать случайный, если хочешь)
        return beispielSet.randomElement()
    }
}
