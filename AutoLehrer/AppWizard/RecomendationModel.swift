import Foundation
import CoreData
import Combine



class RecommendationModel: ObservableObject {
    enum PageMode{
        case MainMenu
    }
    
    enum RecommendationType {
        case mainMenu_trainingForToday
        case mainMenu_welcomeMessage
        case mainMenu_suggestWorkout
        case mainMenu_lazySuggestWorkout
        case mainMenu_oneMoreWorkout
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
        //setup default state
        buttonStates = [
            .mainmenu_trainings : .disabled,
            .mainmenu_statistics : .disabled,
            .mainmenu_exercises : .enabled,
            .mainmenu_equipment : .enabled,
            .mainmenu_muscles : .enabled,
            .mainmenu_locations : .enabled,
            .mainmenu_weightandheight : .enabled,
            .mainmenu_archival : .enabled,
            .mainmenu_language : .enabled,
            .mainmenu_theme : .enabled,
            .mainmenu_thememode : .enabled,
            .mainmenu_configs: .enabled
        ]
        
        recommendation = .none
    }
}
