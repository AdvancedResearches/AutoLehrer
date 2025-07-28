//
//  ArchivalMenu.swift
//  DerTermin
//
//  Created by Алексей Хурсевич on 13.02.24.
//

import Foundation
import SwiftUI
import CoreData

struct ThemesView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var theme: ThemeManager
    
    @AppStorage("appLanguage") var language: String = "ru"
    
    @State var currentTheme: Theme_Style = .regular
    
    let allThemes: [Theme_Style] = [.regular, .herren, .frauen, .cyberpunk, .retrowave]
    
    var body: some View{
        NavigationStack {
            VStack {
                ForEach(allThemes, id: \.self) { theTheme in
                    NG_Button(title: theTheme.fullName.localized(for: language), style: .NG_ButtonStyle_Regular, isDisabled: .constant(theme.currentTheme.themeStyle.fullName != theTheme.fullName), isHighlighting: .constant(false), isPulsating: .constant(false), action: {
                        switch(theTheme){
                        case .regular:
                            if(theme.currentTheme.themeOption == .bright){
                                theme.currentTheme =  theme_regular_bright
                                Settings.setTheme(theTheme.themeNamePrefix+"Bright", in: viewContext)
                            }else{
                                theme.currentTheme =  theme_regular_dark
                                Settings.setTheme(theTheme.themeNamePrefix+"Dark", in: viewContext)
                            }
                        case .herren:
                            if(theme.currentTheme.themeOption == .bright){
                                theme.currentTheme =  theme_herren_bright
                                Settings.setTheme(theTheme.themeNamePrefix+"Bright", in: viewContext)
                            }else{
                                theme.currentTheme =  theme_herren_dark
                                Settings.setTheme(theTheme.themeNamePrefix+"Dark", in: viewContext)
                            }
                        case .frauen:
                            if(theme.currentTheme.themeOption == .bright){
                                theme.currentTheme =  theme_frauen_bright
                                Settings.setTheme(theTheme.themeNamePrefix+"Bright", in: viewContext)
                            }else{
                                theme.currentTheme =  theme_frauen_dark
                                Settings.setTheme(theTheme.themeNamePrefix+"Dark", in: viewContext)
                            }
                        case .cyberpunk:
                            if(theme.currentTheme.themeOption == .bright){
                                theme.currentTheme =  theme_cyberpunk_bright
                                Settings.setTheme(theTheme.themeNamePrefix+"Bright", in: viewContext)
                            }else{
                                theme.currentTheme =  theme_cyberpunk_dark
                                Settings.setTheme(theTheme.themeNamePrefix+"Dark", in: viewContext)
                            }
                        case .retrowave:
                            if(theme.currentTheme.themeOption == .bright){
                                theme.currentTheme =  theme_retrowave_bright
                                Settings.setTheme(theTheme.themeNamePrefix+"Bright", in: viewContext)
                            }else{
                                theme.currentTheme =  theme_retrowave_dark
                                Settings.setTheme(theTheme.themeNamePrefix+"Dark", in: viewContext)
                            }
                        }
                    }, widthFlood: true)
                    .padding(.horizontal)
                }
                Spacer()
            }
            .background(theme.currentTheme.NG_LinearGradient_Background_Page)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(
                leading:
                    BackButton(action: {
                        dismiss()
                    })
            )
        }
    }
}
