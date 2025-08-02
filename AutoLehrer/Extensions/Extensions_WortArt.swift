import CoreData

extension WortArt{
    public static func get_instance(_ wortArtName: String, _ context: NSManagedObjectContext) -> WortArt?{
        return try! context.fetch(WortArt.fetchRequest()).filter{$0.name_DE == wortArtName}.first
    }
    public static func hat_worten(_ wortArtName: String, _ context: NSManagedObjectContext) -> Bool{
        guard let instance = get_instance(wortArtName, context) else{
            return false
        }
        if instance.relWortFormen?.count ?? 0 > 0{
            return true
        }
        return false
    }
    public static func hat_worten(_ wortArt: WortArt) -> Bool{
        if wortArt.relWortFormen?.count ?? 0 > 0{
            return true
        }
        return false
    }
    public static func get_alleWortArten(_ context: NSManagedObjectContext) -> [WortArt]{
        do{
            return try context.fetch(WortArt.fetchRequest()).sorted{$0.order < $1.order}
        }catch{}
        return []
    }
}
