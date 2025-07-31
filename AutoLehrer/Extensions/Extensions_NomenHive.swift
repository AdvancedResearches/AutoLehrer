import CoreData

extension NomenHive{
    public static func coolDown(_ context: NSManagedObjectContext){
        let hotNomenHives: [NomenHive] = try! context.fetch(NomenHive.fetchRequest()).filter{$0.coolDown > 0}
        for theHive in hotNomenHives{
            theHive.coolDown -= 1
        }
        try! context.save()
    }
    public static func get_failedCool(_ context: NSManagedObjectContext) -> [NomenHive]{
        return try! context.fetch(NomenHive.fetchRequest()).filter{$0.coolDown == 0 && $0.failed}.sorted{$0.nomenFrequencyOrder < $1.nomenFrequencyOrder}
    }
    public static func get_successfulCoolTop(_ context: NSManagedObjectContext) -> [NomenHive]{
        let result = try! context.fetch(NomenHive.fetchRequest())
            .filter { $0.coolDown == 0 && !$0.failed && $0.successCounter < 3 }
            .sorted { $0.nomenFrequencyOrder < $1.nomenFrequencyOrder }
            .prefix(20) // ← вот оно
        let top20 = Array(result)
        return top20
    }
    public static func get_successfulCoolRest(_ context: NSManagedObjectContext) -> [NomenHive]{
        let result = try! context.fetch(NomenHive.fetchRequest())
            .filter { $0.coolDown == 0 && !$0.failed && $0.successCounter < 3 }
            .sorted { $0.nomenFrequencyOrder < $1.nomenFrequencyOrder }
            .dropFirst(20)

        let rest = Array(result)
        
        let allTheRest = try! context.fetch(NomenHive.fetchRequest()).filter{$0.coolDown == 0 && !$0.failed && $0.successCounter >= 3}.sorted{$0.nomenFrequencyOrder < $1.nomenFrequencyOrder}
        
        return rest + allTheRest
    }
    public static func get_failedHot(_ context: NSManagedObjectContext) -> [NomenHive]{
        return try! context.fetch(NomenHive.fetchRequest()).filter{$0.coolDown > 0 && $0.failed}.sorted{$0.nomenFrequencyOrder < $1.nomenFrequencyOrder}
    }
    public static func get_successfulHot(_ context: NSManagedObjectContext) -> [NomenHive]{
        return try! context.fetch(NomenHive.fetchRequest()).filter{$0.coolDown > 0 && !$0.failed}.sorted{$0.nomenFrequencyOrder < $1.nomenFrequencyOrder}
    }
    public static func set_success(_ nomenHive: NomenHive){
        guard let context = nomenHive.managedObjectContext else { return }
        nomenHive.successCounter += 1
        try! context.save()
    }
    public static func set_failure(_ nomenHive: NomenHive){
        guard let context = nomenHive.managedObjectContext else { return }
        nomenHive.successCounter = 0
        try! context.save()
    }
}
