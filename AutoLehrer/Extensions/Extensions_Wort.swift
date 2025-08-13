import CoreData


extension Wort{
    public static func get_wortArt_vollString(_ wort: Wort, _ sprache: String) -> String{
        var retValue: String = ""
        let wortArt = wort.relWortFormen?.relWortArt ?? nil
        if(wortArt != nil){
            if(wortArt!.property_1 != nil){
                retValue += get_wortProperty_byPropertyName(wort, wortArt!.property_1!, sprache)
            }
            if(wortArt!.property_2 != nil){
                retValue += " "+get_wortProperty_byPropertyName(wort, wortArt!.property_2!, sprache)
            }
            if(wortArt!.property_3 != nil){
                retValue += " "+get_wortProperty_byPropertyName(wort, wortArt!.property_3!, sprache)
            }
            if(wortArt!.property_4 != nil){
                retValue += " "+get_wortProperty_byPropertyName(wort, wortArt!.property_4!, sprache)
            }
            if(wortArt!.property_5 != nil){
                retValue += " "+get_wortProperty_byPropertyName(wort, wortArt!.property_5!, sprache)
            }
            if(wortArt!.property_6 != nil){
                retValue += " "+get_wortProperty_byPropertyName(wort, wortArt!.property_6!, sprache)
            }
            if(wortArt!.property_7 != nil){
                retValue += " "+get_wortProperty_byPropertyName(wort, wortArt!.property_7!, sprache)
            }
            if(wortArt!.property_8 != nil){
                retValue += " "+get_wortProperty_byPropertyName(wort, wortArt!.property_8!, sprache)
            }
            if(wortArt!.property_9 != nil){
                retValue += " "+get_wortProperty_byPropertyName(wort, wortArt!.property_9!, sprache)
            }
            if(wortArt!.property_10 != nil){
                retValue += " "+get_wortProperty_byPropertyName(wort, wortArt!.property_10!, sprache)
            }
        }
        return retValue
    }
    public static func get_wortProperty_byPropertyName(_ wort: Wort, _ property: String, _ sprache: String) -> String{
        if(property == "genus"){
            return sprache == "DE" ? wort.relGenus?.name_DE! ?? "" : wort.relGenus?.name_RU! ?? ""
        }
        if(property == "kasus"){
            return sprache == "DE" ? wort.relKasus?.name_DE! ?? ""  : wort.relKasus?.name_RU! ?? ""
        }
        if(property == "modus"){
            return sprache == "DE" ? wort.relModus?.name_DE! ?? ""  : wort.relModus?.name_RU! ?? ""
        }
        if(property == "numerus"){
            return sprache == "DE" ? wort.relNumerus?.name_DE! ?? ""  : wort.relNumerus?.name_RU! ?? ""
        }
        if(property == "person"){
            return sprache == "DE" ? wort.relPerson?.name_DE! ?? ""  : wort.relPerson?.name_RU! ?? ""
        }
        if(property == "tempus"){
            return sprache == "DE" ? wort.relTempus?.name_DE! ?? ""  : wort.relTempus?.name_RU! ?? ""
        }
        if(property == "deklination"){
            return sprache == "DE" ? wort.relDeklination?.name_DE! ?? ""  : wort.relDeklination?.name_RU! ?? ""
        }
        if(property == "komparationsgrad"){
            return sprache == "DE" ? wort.relKomparationsgrad?.name_DE! ?? ""  : wort.relKomparationsgrad?.name_RU! ?? ""
        }
        return ""
    }
    public static func get_wortArt_auxString(_ wort: Wort, _ sprache: String) -> String{
        var retValue: String = ""
        let wortArt = wort.relWortFormen?.relWortArt ?? nil
        if(wortArt != nil){
            if wortArt!.name_DE == "Nomen" {
                if(sprache == "RU"){
                    retValue += wort.relKasus!.fragen_RU!
                }
                if(sprache == "DE"){
                    retValue += wort.relKasus!.fragen_DE!
                }
            }
        }
        return retValue
    }
    public static func filter(worte: [Wort], wortArtFormen: WortArtFormen) -> [Wort]{
        var filteredWorten: [Wort] = worte
        if(wortArtFormen.deklination != nil){
            filteredWorten = filteredWorten.filter{$0.relDeklination == wortArtFormen.deklination!}
        }
        if(wortArtFormen.genus != nil){
            filteredWorten = filteredWorten.filter{$0.relGenus == wortArtFormen.genus!}
        }
        if(wortArtFormen.kasus != nil){
            filteredWorten = filteredWorten.filter{$0.relKasus == wortArtFormen.kasus!}
        }
        if(wortArtFormen.komparationsgrad != nil){
            filteredWorten = filteredWorten.filter{$0.relKomparationsgrad == wortArtFormen.komparationsgrad!}
        }
        if(wortArtFormen.modus != nil){
            filteredWorten = filteredWorten.filter{$0.relModus == wortArtFormen.modus!}
        }
        if(wortArtFormen.numerus != nil){
            filteredWorten = filteredWorten.filter{$0.relNumerus == wortArtFormen.numerus!}
        }
        if(wortArtFormen.person != nil){
            filteredWorten = filteredWorten.filter{$0.relPerson == wortArtFormen.person!}
        }
        if(wortArtFormen.tempus != nil){
            filteredWorten = filteredWorten.filter{$0.relTempus == wortArtFormen.tempus!}
        }
        return filteredWorten
    }
    public static func pick_wort(_ wortForm: WortFormen, wortArtFormen: WortArtFormen) -> Wort?{
        guard let context = wortForm.managedObjectContext else {
            return nil
        }
        var filteredWorten: [Wort] = try! context.fetch(Wort.fetchRequest()).filter{$0.relWortFormen == wortForm}
        if(wortArtFormen.deklination != nil){
            filteredWorten = filteredWorten.filter{$0.relDeklination == wortArtFormen.deklination!}
        }
        if(wortArtFormen.genus != nil){
            filteredWorten = filteredWorten.filter{$0.relGenus == wortArtFormen.genus!}
        }
        if(wortArtFormen.kasus != nil){
            filteredWorten = filteredWorten.filter{$0.relKasus == wortArtFormen.kasus!}
        }
        if(wortArtFormen.komparationsgrad != nil){
            filteredWorten = filteredWorten.filter{$0.relKomparationsgrad == wortArtFormen.komparationsgrad!}
        }
        if(wortArtFormen.modus != nil){
            filteredWorten = filteredWorten.filter{$0.relModus == wortArtFormen.modus!}
        }
        if(wortArtFormen.numerus != nil){
            filteredWorten = filteredWorten.filter{$0.relNumerus == wortArtFormen.numerus!}
        }
        if(wortArtFormen.person != nil){
            filteredWorten = filteredWorten.filter{$0.relPerson == wortArtFormen.person!}
        }
        if(wortArtFormen.tempus != nil){
            filteredWorten = filteredWorten.filter{$0.relTempus == wortArtFormen.tempus!}
        }
        return filteredWorten.first
    }
    public static func get_beispiel(_ wort: Wort) -> Beispiel? {
        guard let beispielSet = wort.relBeispiel as? Set<Beispiel>, !beispielSet.isEmpty else {
            return nil
        }

        // Например, вернуть первый элемент (или можешь выбрать случайный, если хочешь)
        return beispielSet.randomElement()
    }
    public static func findOrCreate(in context: NSManagedObjectContext, wortFormen: WortFormen?, wortArtFormen: WortArtFormen) -> Wort {
        var result: Wort? = nil
        do{
            if(wortFormen != nil){
                let setOf = try context.fetch(Wort.fetchRequest()).filter{$0.relWortFormen == wortFormen}
                result = filter(worte: setOf, wortArtFormen: wortArtFormen).first
            }
            if result == nil {
                result = Wort(context: context)
            }
        }catch{}
        return result!
    }
}
