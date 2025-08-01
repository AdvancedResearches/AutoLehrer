import SwiftUI

struct AppWizardView: View {
    @StateObject private var wizardCoordinator = WizardCoordinator()
    @EnvironmentObject var recommendationModel: RecommendationModel
    @EnvironmentObject var theme: ThemeManager
    @AppStorage("appLanguage") var language: String = "ru"
    @Binding var popupEnabled: Bool
    
    var autoClose: Bool
    
    var onWizardFinished: (() -> Void)?
    
    var body: some View {
        Group{
            if popupEnabled {
                VStack{
                    VStack{
                        content
                        if(!autoClose){
                            NG_Button(title: "OK".localized(for: language), style: .NG_ButtonStyle_Green, isDisabled: .constant(false), isHighlighting: .constant(false), isPulsating: .constant(true), action: {
                                withAnimation {
                                    popupEnabled = false
                                }
                            })
                        }
                    }
                    .NG_Card(.NG_CardStyle_AppWizard, theme: theme)
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
                /*
                .onChange(of: recommendationModel.recommendation){ oldValue, newValue in
                }
                */
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
        }
            .onTapGesture {
            }
        }
    
    private var recommendationText: String {
        switch recommendationModel.recommendation {
        case .none:
            return "Как дела?".localized(for: language)
        }
    }
    
    private var iconName: String {
        switch recommendationModel.recommendation {
        case .none:
            return "bubble.left"
        }
    }
}
