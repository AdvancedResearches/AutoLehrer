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
        return try! context.fetch(NomenHive.fetchRequest()).filter{$0.coolDown == 0 && $0.failed}
    }
    public static func get_successfulCool(_ context: NSManagedObjectContext) -> [NomenHive]{
        return try! context.fetch(NomenHive.fetchRequest()).filter{$0.coolDown == 0 && !$0.failed}
    }
    public static func get_failedHot(_ context: NSManagedObjectContext) -> [NomenHive]{
        return try! context.fetch(NomenHive.fetchRequest()).filter{$0.coolDown > 0 && $0.failed}
    }
    public static func get_successfulHot(_ context: NSManagedObjectContext) -> [NomenHive]{
        return try! context.fetch(NomenHive.fetchRequest()).filter{$0.coolDown > 0 && !$0.failed}
    }
}
