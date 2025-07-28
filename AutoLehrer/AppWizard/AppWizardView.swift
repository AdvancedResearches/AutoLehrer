import SwiftUI

struct AppWizardView: View {
    @StateObject private var wizardCoordinator = WizardCoordinator()
    @EnvironmentObject var recommendationModel: RecommendationModel
    @EnvironmentObject var theme: ThemeManager
    @AppStorage("appLanguage") var language: String = "en"
    @Binding var popupEnabled: Bool
    
    var autoClose: Bool
    
    var onWizardFinished: (() -> Void)?
    
    var body: some View {
        Group{
            if popupEnabled {
                VStack{
                    VStack{
                        if recommendationModel.recommendation == .mainMenu_welcomeMessage{
                            WizardContainerView(coordinator: wizardCoordinator)
                        }else if recommendationModel.recommendation == .mainMenu_suggestWorkout{
                            WizardContainerView(coordinator: wizardCoordinator)
                        }else{
                            content
                            if(!autoClose){
                                NG_Button(title: "OK".localized(for: language), style: .NG_ButtonStyle_Green, isDisabled: .constant(false), isHighlighting: .constant(false), isPulsating: .constant(true), action: {
                                    withAnimation {
                                        popupEnabled = false
                                    }
                                })
                            }
                        }
                    }
                    .NG_Card(.NG_CardStyle_AppWizard, theme: theme)
                    //.frame(maxWidth: 300)
                    .padding(.horizontal, 10)
                    .shadow(radius: 10)
                }
                .onAppear {
                    if autoClose {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            withAnimation {
                                popupEnabled = false
                            }
                        }
                    }
                }
                .onChange(of: recommendationModel.recommendation){ oldValue, newValue in
                }
            }else{
                content
                .NG_Card(.NG_CardStyle_AppWizard, theme: theme)
                .padding(.horizontal, 5)
            }
        }
        .animation(.easeInOut, value: popupEnabled)
    }
    
    private var content: some View {
        VStack{
            HStack(alignment: .top) {
                Image(systemName: iconName)
                    .NG_iconStyling(.NG_IconStyle_Regular, isDisabled: .constant(false), isHighlighting: .constant(true), isPulsating: .constant(false), theme: theme)
                Text(recommendationText)
                    .NG_textStyling(.NG_TextStyle_AppWizard, glare: true, pulsation: false, theme: theme)
                Spacer()
            }
            if(recommendationModel.recommendation == .mainMenu_lazySuggestWorkout){
                NG_Button(title: "Yes".localized(for: language), style: .NG_ButtonStyle_Green, isDisabled: .constant(false), isHighlighting: .constant(false), isPulsating: .constant(false), action: {
                    recommendationModel.recommendation = .mainMenu_suggestWorkout
                }, widthFlood: true)
                if(popupEnabled){
                    NG_Button(title: "No, thanks".localized(for: language), style: .NG_ButtonStyle_Regular, isDisabled: .constant(false), isHighlighting: .constant(false), isPulsating: .constant(false), action: {
                        withAnimation {
                            popupEnabled = false
                        }
                    }, widthFlood: true)
                }
            }
            if(recommendationModel.recommendation == .mainMenu_oneMoreWorkout){
                NG_Button(title: "Let's do that!".localized(for: language), style: .NG_ButtonStyle_Green, isDisabled: .constant(false), isHighlighting: .constant(false), isPulsating: .constant(false), action: {
                    recommendationModel.recommendation = .mainMenu_suggestWorkout
                }, widthFlood: true)
                if(popupEnabled){
                    NG_Button(title: "No, thanks".localized(for: language), style: .NG_ButtonStyle_Regular, isDisabled: .constant(false), isHighlighting: .constant(false), isPulsating: .constant(false), action: {
                        withAnimation {
                            popupEnabled = false
                        }
                    }, widthFlood: true)
                }
            }
        }
            .onTapGesture {
                if(recommendationModel.recommendation == .mainMenu_lazySuggestWorkout){
                    recommendationModel.recommendation = .mainMenu_suggestWorkout
                }
            }
        }
    
    private var recommendationText: String {
        switch recommendationModel.recommendation {
        case .mainMenu_trainingForToday:
            return "You have a workout planned for today".localized(for: language)
        case .none:
            return "How you doing?".localized(for: language)
        case .mainMenu_welcomeMessage:
            return ""
        case .mainMenu_suggestWorkout:
            return ""
        case .mainMenu_lazySuggestWorkout:
            return "Would you like to workout today?".localized(for: language)
        case .mainMenu_oneMoreWorkout:
            return "One more workout today?".localized(for: language)
        }
    }
    
    private var iconName: String {
        switch recommendationModel.recommendation {
        case .mainMenu_trainingForToday:
            return "star.bubble"
        case .none:
            return "bubble.left"
        case .mainMenu_welcomeMessage:
            return ""
        case .mainMenu_suggestWorkout:
            return ""
        case .mainMenu_lazySuggestWorkout:
            return "questionmark.diamond"
        case .mainMenu_oneMoreWorkout:
            return "questionmark.diamond"
        }
    }
}
