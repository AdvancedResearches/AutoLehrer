import CoreData

extension WortArt{
    public static func confirmedRatio(_ wortArt: WortArt) -> Double{
        let alleWortFormen: [WortFormen] =
            Array(wortArt.relWortFormen as? Set<WortFormen> ?? [])
        let confirmedWortFormen = alleWortFormen.filter{$0.state == WortFormen.state_weekly}
        
        if alleWortFormen.count > 0 {
            return Double(confirmedWortFormen.count) / Double(alleWortFormen.count)
        }
        
        return 0
    }
    public static func attemptingRatio(_ wortArt: WortArt) -> Double{
        let alleWortFormen: [WortFormen] =
            Array(wortArt.relWortFormen as? Set<WortFormen> ?? [])
        let attemptingWortFormen = alleWortFormen.filter{$0.state != WortFormen.state_never}
        
        if alleWortFormen.count > 0 {
            return Double(attemptingWortFormen.count) / Double(alleWortFormen.count)
        }
        
        return 0
    }
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
    public static func findOrCreate(in context: NSManagedObjectContext, withName_DE name_DE: String) -> WortArt {
        var result: WortArt? = nil
        do{
            result = try context.fetch(WortArt.fetchRequest()).filter{$0.name_DE == name_DE}.first
            if result == nil {
                result = WortArt(context: context)
            }
        }catch{}
        return result!
    }
    public static func fetch_alleConfirmedWorten(_ wortArt: WortArt) -> [Wort]{
        var retValue: [Wort] = []
        let allWortFormen: [WortFormen] = Array(wortArt.relWortFormen as? Set<WortFormen> ?? []).filter{$0.formsToShow >= 1}
        
        for theWortForm in allWortFormen{
            let alleFormenToTry = WortFormen.retrieve_allAllowedFormen(theWortForm, includeLastAttempting: false)
            retValue.append(contentsOf: alleFormenToTry)
        }
        
        return retValue
    }
}
