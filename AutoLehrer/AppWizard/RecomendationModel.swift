import Foundation
import CoreData
import Combine



class RecommendationModel: ObservableObject {
    enum PageMode{
        case MainMenu
    }
    
    enum RecommendationType {
        case none
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

    @Published var recommendation: RecommendationType = .none
    @Published var buttonStates: [ButtonSet: ButtonState] = [:]

    func update(for pageMode: PageMode, in context: NSManagedObjectContext) {
        switch pageMode{
        case .MainMenu: update_mainMenu(in: context)
        }
    }
    
    private func update_mainMenu(in context: NSManagedObjectContext) {
        recommendation = .none
    }
}
