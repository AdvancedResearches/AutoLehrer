import CoreData

extension Wort{
    public static func get_wortArt_vollString(_ wort: Wort, _ sprache: String) -> String{
        var retValue: String = ""
        let wortArt = wort.relWortFormen?.relWortArt ?? nil
        if(wortArt != nil){
            /*
            if wortArt!.name_DE == "Nomen" {
                if(sprache == "RU"){
                    retValue += wort.relKasus!.name_RU! + " " + wort.relNumerus!.name_RU!
                }
                if(sprache == "DE"){
                    retValue += wort.relKasus!.name_DE! + " " + wort.relNumerus!.name_DE!
                }
            }
             */
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
            return sprache == "DE" ? wort.relGenus!.name_DE! : wort.relGenus!.name_RU!
        }
        if(property == "kasus"){
            return sprache == "DE" ? wort.relKasus!.name_DE! : wort.relKasus!.name_RU!
        }
        if(property == "modus"){
            return sprache == "DE" ? wort.relModus!.name_DE! : wort.relModus!.name_RU!
        }
        if(property == "numerus"){
            return sprache == "DE" ? wort.relNumerus!.name_DE! : wort.relNumerus!.name_RU!
        }
        if(property == "person"){
            return sprache == "DE" ? wort.relPerson!.name_DE! : wort.relPerson!.name_RU!
        }
        if(property == "tempus"){
            return sprache == "DE" ? wort.relTempus!.name_DE! : wort.relTempus!.name_RU!
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
    public static func get_beispiel(_ wort: Wort) -> Beispiel? {
        guard let beispielSet = wort.relBeispiel as? Set<Beispiel>, !beispielSet.isEmpty else {
            return nil
        }

        // Например, вернуть первый элемент (или можешь выбрать случайный, если хочешь)
        return beispielSet.randomElement()
    }
}
