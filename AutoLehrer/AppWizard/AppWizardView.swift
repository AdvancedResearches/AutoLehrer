import SwiftUI

struct AppWizardView: View {
    @StateObject private var wizardCoordinator = WizardCoordinator()
    @EnvironmentObject var recommendationModel: RecommendationModel
    @EnvironmentObject var theme: ThemeManager
    @AppStorage("appLanguage") var language: String = "ru"
    @Binding var popupEnabled: Bool
    @Environment(\.managedObjectContext) private var viewContext
    
    @State var prufung_isActive: Bool = false
    
    //var autoClose: Bool
    
    var onWizardFinished: (() -> Void)?
    
    var body: some View {
        
        Group{
            if recommendationModel.popupEnabled {
                VStack{
                    VStack{
                        if(recommendationModel.recommendation == .keinPrufungHeute){
                            content
                            HStack{
                                Spacer()
                                NavigationLink(
                                    destination: WortRepeater(wortArt: WortArt.get_alleWortArten(viewContext).first! , prufungModus: true).NG_NavigationTitle("Экзамен", theme: theme),
                                    isActive: $prufung_isActive
                                ) {
                                    Group {
                                        NG_Button(
                                            title: "Давай!",
                                            style: .NG_ButtonStyle_Green,
                                            isDisabled: .constant(false),
                                            isHighlighting: .constant(false),
                                            isPulsating: .constant(true),
                                            widthFlood: true
                                        )
                                    }
                                }
                                .onChange(of: prufung_isActive){ alteValue, neueValue in
                                    if(alteValue && !neueValue){
                                        recommendationModel.update(for: .MainMenu, in: viewContext)
                                    }
                                }
                                Spacer()
                                NG_Button(title: "Не сейчас".localized(for: language), style: .NG_ButtonStyle_Red, isDisabled: .constant(false), isHighlighting: .constant(false), isPulsating: .constant(false), action: {
                                    withAnimation {
                                        recommendationModel.popupEnabled = false
                                    }
                                })
                                Spacer()
                            }
                        } else if(recommendationModel.recommendation == .keinPrufungDieseWoche){
                            content
                            HStack{
                                Spacer()
                                NavigationLink(
                                    destination: WortRepeater(wortArt: WortArt.get_alleWortArten(viewContext).first! , prufungModus: true).NG_NavigationTitle("Экзамен", theme: theme),
                                    isActive: $prufung_isActive
                                ) {
                                    Group {
                                        NG_Button(
                                            title: "Давай!",
                                            style: .NG_ButtonStyle_Green,
                                            isDisabled: .constant(false),
                                            isHighlighting: .constant(false),
                                            isPulsating: .constant(true),
                                            widthFlood: true
                                        )
                                    }
                                }
                                .onChange(of: prufung_isActive){ alteValue, neueValue in
                                    if(alteValue && !neueValue){
                                        recommendationModel.update(for: .MainMenu, in: viewContext)
                                    }
                                }
                                Spacer()
                                NG_Button(title: "Не сейчас".localized(for: language), style: .NG_ButtonStyle_Red, isDisabled: .constant(false), isHighlighting: .constant(false), isPulsating: .constant(false), action: {
                                    withAnimation {
                                        recommendationModel.popupEnabled = false
                                    }
                                })
                                Spacer()
                            }
                        } else if(recommendationModel.recommendation == .keinPrufungLangeZeit){
                            content
                            HStack{
                                Spacer()
                                NavigationLink(
                                    destination: WortRepeater(wortArt: WortArt.get_alleWortArten(viewContext).first! , prufungModus: true).NG_NavigationTitle("Экзамен", theme: theme),
                                    isActive: $prufung_isActive
                                ) {
                                    Group {
                                        NG_Button(
                                            title: "Давай!",
                                            style: .NG_ButtonStyle_Green,
                                            isDisabled: .constant(false),
                                            isHighlighting: .constant(false),
                                            isPulsating: .constant(true),
                                            widthFlood: true
                                        )
                                    }
                                }
                                .onChange(of: prufung_isActive){ alteValue, neueValue in
                                    if(alteValue && !neueValue){
                                        recommendationModel.update(for: .MainMenu, in: viewContext)
                                    }
                                }
                                Spacer()
                                NG_Button(title: "Не сейчас".localized(for: language), style: .NG_ButtonStyle_Red, isDisabled: .constant(false), isHighlighting: .constant(false), isPulsating: .constant(false), action: {
                                    withAnimation {
                                        recommendationModel.popupEnabled = false
                                    }
                                })
                                Spacer()
                            }
                        } else if(recommendationModel.recommendation == .keinPrufungNie){
                            content
                            HStack{
                                Spacer()
                                NavigationLink(
                                    destination: WortRepeater(wortArt: WortArt.get_alleWortArten(viewContext).first! , prufungModus: true).NG_NavigationTitle("Экзамен", theme: theme),
                                    isActive: $prufung_isActive
                                ) {
                                    Group {
                                        NG_Button(
                                            title: "Давай!",
                                            style: .NG_ButtonStyle_Green,
                                            isDisabled: .constant(false),
                                            isHighlighting: .constant(false),
                                            isPulsating: .constant(true),
                                            widthFlood: true
                                        )
                                    }
                                }
                                .onChange(of: prufung_isActive){ alteValue, neueValue in
                                    if(alteValue && !neueValue){
                                        recommendationModel.update(for: .MainMenu, in: viewContext)
                                    }
                                }
                                Spacer()
                                NG_Button(title: "Не сейчас".localized(for: language), style: .NG_ButtonStyle_Red, isDisabled: .constant(false), isHighlighting: .constant(false), isPulsating: .constant(false), action: {
                                    withAnimation {
                                        recommendationModel.popupEnabled = false
                                    }
                                })
                                Spacer()
                            }
                        } else {
                            content
                            if(!recommendationModel.autoClose){
                                NG_Button(title: "OK".localized(for: language), style: .NG_ButtonStyle_Green, isDisabled: .constant(false), isHighlighting: .constant(false), isPulsating: .constant(true), action: {
                                    withAnimation {
                                        recommendationModel.popupEnabled = false
                                    }
                                })
                            }
                        }
                    }
                    .NG_Card(.NG_CardStyle_AppWizard, theme: theme)
                    .padding(.horizontal, 10)
                    .shadow(radius: 10)
                }
                .onAppear {
                    if recommendationModel.autoClose {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            withAnimation {
                                recommendationModel.popupEnabled = false
                            }
                        }
                    }
                }
            }else{
                content
                .NG_Card(.NG_CardStyle_AppWizard, theme: theme)
                .padding(.horizontal, 5)
            }
        }
        .animation(.easeInOut, value: recommendationModel.popupEnabled)
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
        case .noneAgain:
            return "Как дела?".localized(for: language)
        case .keinPrufungHeute:
            return "Сегодня ещё не прводился экзамен. Устроим?"
        case .keinPrufungDieseWoche:
            return "На этой неделе ещё не проводился экзамен. Устроим?"
        case .keinPrufungLangeZeit:
            return "Чего-то давно уже экзамен не проводился. Устроим?"
        case .keinPrufungNie:
            return "Ещё никогда не проводился экзамен. Устроим?"
        }
    }
    
    private var iconName: String {
        switch recommendationModel.recommendation {
        case .none:
            return "bubble.left"
        case .noneAgain:
            return "bubble.left"
        case .keinPrufungHeute:
            return "questionmark.circle"
        case .keinPrufungDieseWoche:
            return "questionmark.square"
        case .keinPrufungLangeZeit:
            return "questionmark.diamond"
        case .keinPrufungNie:
            return "star.bubble"
        }
    }
}
