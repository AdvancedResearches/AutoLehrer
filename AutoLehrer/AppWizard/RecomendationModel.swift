import Foundation
import CoreData
import Combine



class RecommendationModel: ObservableObject {
    enum PageMode{
        case MainMenu
    }
    
    enum RecommendationType {
        case none
        case noneAgain
        case keinPrufungHeute
        case keinPrufungDieseWoche
        case keinPrufungLangeZeit
        case keinPrufungNie
    }
    
    enum ButtonSet {
        case mainmenu_trainings
        case mainmenu_statistics
        case mainmenu_exercises
        case mainmenu_equipment
        case mainmenu_muscles
        case mainmenu_locations
        case mainmenu_weightandheight
        case mainmenu_archival
        case mainmenu_language
        case mainmenu_theme
        case mainmenu_thememode
        case mainmenu_configs
    }
    
    enum ButtonState {
        case disabled
        case enabled
        case highlighted
        case pulsating
    }
    
    var shallBeNone: Bool = true

    @Published var recommendation: RecommendationType = .none
    @Published var buttonStates: [ButtonSet: ButtonState] = [:]
    @Published var autoClose: Bool = false
    @Published var popupEnabled: Bool = true

    func update(for pageMode: PageMode, in context: NSManagedObjectContext) {
        switch pageMode{
        case .MainMenu: update_mainMenu(in: context)
        }
    }
    
    private func update_mainMenu(in context: NSManagedObjectContext) {
        if(shallBeNone){
            recommendation = .none
            recommendation = .noneAgain
            shallBeNone = false
            autoClose = false
            popupEnabled = true
        }else{
            recommendation = .noneAgain
            autoClose = true
            popupEnabled = false
        }
        
        let prunungBereit = TimeStatistics.auslesen_bereitFurPrufung(context)
        if(prunungBereit){
            print("RecommendationModel: PrufungBereit detected")
            let hatHeutePrufungGefragt = Settings.auslesenPrufungHeuteGefragt(in: context)
            if(!hatHeutePrufungGefragt){
                print("RecommendationModel: Die erste zeit heute wann fragen nach Prufung")
                let keinPrufungDauert = Settings.auslesenKeinPrufungDauert(in: context)
                print("RecommendationModel: Dauert ist \(keinPrufungDauert)")
                if (keinPrufungDauert == Settings.Nie){
                    recommendation = .keinPrufungNie
                    shallBeNone = false
                    autoClose = false
                    popupEnabled = true
                    print("RecommendationModel: Ersetzt die NIE modus")
                    return
                }
                if (keinPrufungDauert > 7){
                    recommendation = .keinPrufungLangeZeit
                    shallBeNone = false
                    autoClose = false
                    popupEnabled = true
                    print("RecommendationModel: Ersetzt die LANGEZEIT modus")
                    return
                }
                if (keinPrufungDauert > 1){
                    let minutesSpentToday: Int = TimeStatistics.auslesen_WieVieleMinutenHeute(context)
                    if(minutesSpentToday >= 5){
                        recommendation = .keinPrufungDieseWoche
                        shallBeNone = false
                        autoClose = false
                        popupEnabled = true
                        print("RecommendationModel: Ersetzt die DIESEWOCHE modus")
                        return
                    }
                }
                    let minutesSpentToday: Int = TimeStatistics.auslesen_WieVieleMinutenHeute(context)
                    if(minutesSpentToday >= 15){
                        recommendation = .keinPrufungHeute
                        shallBeNone = false
                        autoClose = false
                        popupEnabled = true
                        print("RecommendationModel: Ersetzt die HEUTE modus")
                        return
                    }
            }else{
                print("RecommendationModel: NICHT Die erste zeit heute wann fragen nach Prufung")
            }
        } else{
            print("RecommendationModel: KEIN PrufungBereit detected")
        }
    }
}
