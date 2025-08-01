import CoreData

extension WortArt{
    public static func get_instance(_ wortArtName: String, _ context: NSManagedObjectContext) -> WortArt?{
        return try! context.fetch(WortArt.fetchRequest()).filter{$0.name_DE == wortArtName}.first
    }
}
