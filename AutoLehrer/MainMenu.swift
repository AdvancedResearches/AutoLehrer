//
//  ContentView.swift
//  GymRat
//
//  Created by Алексей Хурсевич on 04.12.24.
//

import SwiftUI
import CoreData

struct MainMenu: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.scenePhase) private var scenePhase
    @EnvironmentObject var theme: ThemeManager
    @EnvironmentObject var recommendationModel: RecommendationModel
    @AppStorage("appLanguage") var language: String = "ru"
    
    @State var ThisTraining_disabled: Bool = false
    @State var ThisTraining_highlighted: Bool = false
    @State var ThisTraining_pulsating: Bool = false
    @State var Trainings_disabled: Bool = false
    @State var Trainings_highlighted: Bool = false
    @State var Trainings_pulsating: Bool = false
    @State var Exercises_disabled: Bool = false
    @State var Exercises_highlighted: Bool = false
    @State var Exercises_pulsating: Bool = false
    @State var Workouts_disabled: Bool = false
    @State var Workouts_highlighted: Bool = false
    @State var Workouts_pulsating: Bool = false
    @State var Statistics_disabled: Bool = false
    @State var Statistics_highlighted: Bool = false
    @State var Statistics_pulsating: Bool = false
    @State var Milestones_disabled: Bool = false
    @State var Milestones_highlighted: Bool = false
    @State var Milestones_pulsating: Bool = false
    @State var Recurrencies_disabled: Bool = false
    @State var Recurrencies_highlighted: Bool = false
    @State var Recurrencies_pulsating: Bool = false
    @State var Equipment_disabled: Bool = false
    @State var Equipment_highlighted: Bool = false
    @State var Equipment_pulsating: Bool = false
    @State var Muscles_disabled: Bool = false
    @State var Muscles_highlighted: Bool = false
    @State var Muscles_pulsating: Bool = false
    @State var Locations_disabled: Bool = false
    @State var Locations_highlighted: Bool = false
    @State var Locations_pulsating: Bool = false
    @State var Archival_disabled: Bool = false
    @State var Archival_highlighted: Bool = false
    @State var Archival_pulsating: Bool = false
    @State var Presets_disabled: Bool = false
    @State var Presets_highlighted: Bool = false
    @State var Presets_pulsating: Bool = false
    @State var Locale_disabled: Bool = false
    @State var Locale_highlighted: Bool = false
    @State var Locale_pulsating: Bool = false
    @State var Theme_disabled: Bool = false
    @State var Theme_highlighted: Bool = false
    @State var Theme_pulsating: Bool = false
    @State var Configs_disabled: Bool = false
    @State var Configs_highlighted: Bool = false
    @State var Configs_pulsating: Bool = false
    
    @State private var ThisTraining_isActive: Bool = false
    @State private var Trainings_isActive: Bool = false
    @State private var Exercises_isActive: Bool = false
    @State private var Sets_isActive: Bool = false
    @State private var Statistics_isActive: Bool = false
    @State private var Milestones_isActive: Bool = false
    @State private var Recurrencies_isActive: Bool = false
    @State private var Equipment_isActive: Bool = false
    @State private var Muscles_isActive: Bool = false
    @State private var Locations_isActive: Bool = false
    @State private var WeightAndHeight_isActive: Bool = false
    @State private var Archival_isActive: Bool = false
    @State private var Presets_isActive: Bool = false
    @State private var Locale_isActive: Bool = false
    @State private var Theme_isActive: Bool = false
    @State private var Configs_isActive: Bool = false
    
    @State private var locale_short: String = LocaleView.LocaleItem.english.shortName
    
    @State private var appwizardPopupEnabled = true
    
    @State private var previousWizardRecommendation: RecommendationModel.RecommendationType = .none
    @State private var autoCloseWizard: Bool = false
    
    init(){
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor.green
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.black], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.black], for: .normal)
        UISegmentedControl.appearance().backgroundColor = UIColor.gray
    }
    
    var body: some View {
        NavigationStack{
            ZStack{
                ScrollView{
                    if !appwizardPopupEnabled {
                        AppWizardView(popupEnabled: $appwizardPopupEnabled, autoClose: autoCloseWizard)
                    }
                    VStack{
                        Text("Учить".localized(for: language))
                            .NG_textStyling(.NG_TextStyle_SectionHeader, theme: theme)
                        
                        let wortArten = WortArt.get_alleWortArten(viewContext)

                        LazyVGrid(columns: [GridItem(.flexible(), spacing: 5)], spacing: 5){
                            ForEach(wortArten){ wortArt in
                                NavigationLink(
                                    destination: WortRepeater(wortArt: wortArt).NG_NavigationTitle(wortArt.name_RU!, theme: theme)
                                ) {
                                    Group {
                                        let state = recommendationModel.buttonStates[.mainmenu_trainings] ?? .enabled
                                        NG_Button(
                                            title: wortArt.name_RU!,
                                            style: .NG_ButtonStyle_Regular,
                                            isDisabled: .constant(!WortArt.hat_worten(wortArt)),
                                            isHighlighting: .constant(false),
                                            isPulsating: .constant(false),
                                            widthFlood: true
                                        )
                                    }
                                }
                            }
                        }
                    }
                    .NG_Card(.NG_CardStyle_Regular, theme: theme)
                    .padding(.horizontal)
                    
                    VStack(alignment: .leading){
                        Text("Статистика")
                            .NG_textStyling(.NG_TextStyle_SectionHeader, theme: theme)
                        Text("Существительные")
                            .NG_textStyling(.NG_TextStyle_Text_Regular, theme: theme)
                        let nomenInstance = WortArt.get_instance("Nomen", viewContext)
                        if(nomenInstance != nil){
                            let nomen_total = Statistics.get_wort_total(viewContext, nomenInstance!)
                            let nomen_confirmed = Statistics.get_wort_confirmed(viewContext, nomenInstance!)
                            let nomen_confirmed_ratio = Double(nomen_confirmed)/Double(nomen_total)*100
                            let nomen_attempted = Statistics.get_wort_attempted(viewContext, nomenInstance!)
                            let nomen_attempted_ratio = Double(nomen_attempted)/Double(nomen_total)*100
                            Text("Всего: \(nomen_total)")
                                .NG_textStyling(.NG_TextStyle_Text_Regular, theme: theme)
                                .padding(.leading, 10)
                            Text("Выучено: \(nomen_confirmed) (\(String(format: "%.1f", nomen_confirmed_ratio))%)")
                                .NG_textStyling(.NG_TextStyle_Text_Regular, theme: theme)
                                .padding(.leading, 10)
                            Text("Опробовано: \(nomen_attempted) (\(String(format: "%.1f", nomen_attempted_ratio))%)")
                                .NG_textStyling(.NG_TextStyle_Text_Regular, theme: theme)
                                .padding(.leading, 10)
                        }else{
                            Text("нет данных")
                                .NG_textStyling(.NG_TextStyle_Text_Regular, theme: theme)
                                .padding(.leading, 10)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .NG_Card(.NG_CardStyle_Regular, theme: theme)
                    .padding(.horizontal)
                    
                    VStack{
                        Text("Служебные функции".localized(for: language))
                            .NG_textStyling(.NG_TextStyle_SectionHeader, theme: theme)
                        LazyVGrid(columns: [GridItem(.flexible(), spacing: 5), GridItem(.flexible(), spacing: 5)], spacing: 5){
                            
                            NavigationLink(
                                destination: ThemesView().NG_NavigationTitle("Тема".localized(for: language), theme: theme),
                                isActive: $Theme_isActive
                            ) {
                                Group {
                                    let state = recommendationModel.buttonStates[.mainmenu_theme] ?? .enabled
                                    NG_Button(
                                        title: "Тема".localized(for: language),
                                        style: .NG_ButtonStyle_Service,
                                        isDisabled: .constant(state == .disabled),
                                        isHighlighting: .constant(state == .highlighted),
                                        isPulsating: .constant(state == .pulsating),
                                        widthFlood: true
                                    )
                                }
                            }
                            .onChange(of: Theme_isActive){newValue in
                                if !newValue{
                                    invokeUpdates()
                                }
                            }
                            
                            Group{
                                let state = recommendationModel.buttonStates[.mainmenu_thememode] ?? .enabled
                                NG_Button(title: theme.currentTheme.themeOption == Theme_Option.bright ? "Светлая".localized(for: language) : "Тёмная".localized(for: language), style: .NG_ButtonStyle_Service, isDisabled: .constant(state == .disabled), isHighlighting: .constant(state == .highlighted), isPulsating: .constant(state == .pulsating), action:{
                                    switch theme.currentTheme.themeOption{
                                    case Theme_Option.bright:
                                        switch(theme.currentTheme.themeStyle){
                                        case .regular:
                                            theme.currentTheme =  theme_regular_dark
                                            Settings.setTheme(theme.currentTheme.themeStyle.themeNamePrefix+"Dark", in: viewContext)
                                        case .herren:
                                            theme.currentTheme =  theme_herren_dark
                                            Settings.setTheme(theme.currentTheme.themeStyle.themeNamePrefix+"Dark", in: viewContext)
                                        case .frauen:
                                            theme.currentTheme =  theme_frauen_dark
                                            Settings.setTheme(theme.currentTheme.themeStyle.themeNamePrefix+"Dark", in: viewContext)
                                        case .cyberpunk:
                                            theme.currentTheme =  theme_cyberpunk_dark
                                            Settings.setTheme(theme.currentTheme.themeStyle.themeNamePrefix+"Dark", in: viewContext)
                                        case .retrowave:
                                            theme.currentTheme =  theme_retrowave_dark
                                            Settings.setTheme(theme.currentTheme.themeStyle.themeNamePrefix+"Dark", in: viewContext)
                                        }
                                    case Theme_Option.dark:
                                        switch(theme.currentTheme.themeStyle){
                                        case .regular:
                                            theme.currentTheme =  theme_regular_bright
                                            Settings.setTheme(theme.currentTheme.themeStyle.themeNamePrefix+"Bright", in: viewContext)
                                        case .herren:
                                            theme.currentTheme =  theme_herren_bright
                                            Settings.setTheme(theme.currentTheme.themeStyle.themeNamePrefix+"Bright", in: viewContext)
                                        case .frauen:
                                            theme.currentTheme =  theme_frauen_bright
                                            Settings.setTheme(theme.currentTheme.themeStyle.themeNamePrefix+"Bright", in: viewContext)
                                        case .cyberpunk:
                                            theme.currentTheme =  theme_cyberpunk_bright
                                            Settings.setTheme(theme.currentTheme.themeStyle.themeNamePrefix+"Bright", in: viewContext)
                                        case .retrowave:
                                            theme.currentTheme =  theme_retrowave_bright
                                            Settings.setTheme(theme.currentTheme.themeStyle.themeNamePrefix+"Bright", in: viewContext)
                                        }
                                        
                                    }
                                }, widthFlood: true)
                            }
                            
                            NavigationLink(
                                destination: ArchivalMenu().NG_NavigationTitle("Архив", theme: theme),
                                isActive: $Archival_isActive
                            ) {
                                Group {
                                    let state = recommendationModel.buttonStates[.mainmenu_archival] ?? .enabled
                                    NG_Button(
                                        title: "Архив",
                                        style: .NG_ButtonStyle_Service,
                                        isDisabled: .constant(state == .disabled),
                                        isHighlighting: .constant(state == .highlighted),
                                        isPulsating: .constant(state == .pulsating),
                                        widthFlood: true
                                    )
                                }
                            }
                            .onChange(of: Archival_isActive){ /*oldValue, */newValue in
                                if !newValue{
                                    invokeUpdates()
                                }
                            }
                            .disabled(Archival_disabled)
                        }
                    }
                    .NG_Card(.NG_CardStyle_Regular, theme: theme)
                    .padding(.horizontal)
                }
                .disabled(appwizardPopupEnabled)
                .blur(radius: appwizardPopupEnabled ? 1 : 0)
                
                if appwizardPopupEnabled {
                    AppWizardView(popupEnabled: $appwizardPopupEnabled, autoClose: autoCloseWizard, onWizardFinished: {
                        invokeUpdates()
                    })
                        .transition(.scale.combined(with: .opacity))
                        .zIndex(1)
                }
            }
            .NG_NavigationTitle("Cards Ru-DE", theme: theme)
            .background(theme.currentTheme.NG_LinearGradient_Background_Page)
            .navigationBarBackButtonHidden(true)
        }
        .onAppear{
            invokeUpdates()
            reloadPresets()
        }
        .onChange(of: scenePhase) { newPhase in
            if newPhase == .active {
                invokeUpdates()
            }
        }
        .onChange(of: recommendationModel.recommendation){ newRecomendation in
            updateUI()
        }
    }
    private func invokeUpdates(){
        recommendationModel.update(for: .MainMenu, in: viewContext)
    }
    private func reloadPresets(){
        let fileDirectory: URL? = Bundle.main.resourceURL
        if let presetFiles = Bundle.main.urls(forResourcesWithExtension: "alpres", subdirectory: nil) {
            for fileURL in presetFiles.sorted{$0.lastPathComponent < $1.lastPathComponent} {
                viewContext.performAndWait{
                    Data_Archival(theFile: fileDirectory!.appendingPathComponent(fileURL.lastPathComponent), theContext: viewContext).preset()
                    do{
                        try viewContext.save()
                    }catch{}
                }
            }
        }
    }
    private func updateUI(){
        autoCloseWizard = true
        appwizardPopupEnabled = true
        previousWizardRecommendation = recommendationModel.recommendation
    }
}
