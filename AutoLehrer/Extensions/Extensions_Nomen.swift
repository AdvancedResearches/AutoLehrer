import CoreData

extension Nomen{
    public static func pick_nomenative_singular(_ nomenHive: NomenHive) -> Nomen{
        let context = nomenHive.managedObjectContext!
        let kasus = try! context.fetch(Kasus.fetchRequest()).filter{$0.name_DE == "Nominativ"}.first!
        let numerus = try! context.fetch(Numerus.fetchRequest()).filter{$0.name_DE == "Singular"}.first!
        guard let nomenSet = nomenHive.relNomen as? Set<Nomen>,
              let match = nomenSet.first(where: { $0.relKasus == kasus && $0.relNumerus == numerus }) else {
            fatalError("Не найден Nomen для заданных kasus и numerus")
        }
        return match
    }
}
