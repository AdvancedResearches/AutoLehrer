//
//  ArchivalMenu.swift
//  DerTermin
//
//  Created by Алексей Хурсевич on 13.02.24.
//

import Foundation
import SwiftUI
import CoreData

struct LocaleView: View {
    enum LocaleItem: String, CaseIterable {
        case english
        case russian
        case czech
        case polish
        case french
        case german
        case spanish
        case ukrainian
        
        var fullName: String {
            switch self {
            case .english:   return "English"
            case .russian:   return "Русский"
            case .czech:     return "Čeština"
            case .polish:    return "Polski"
            case .french:    return "Français"
            case .german:    return "Deutsch"
            case .spanish:   return "Español"
            case .ukrainian: return "Український"
            }
        }
        
        var shortName: String {
            switch self {
            case .english:   return "EN"
            case .russian:   return "РУ"
            case .czech:     return "ČE"
            case .polish:    return "PO"
            case .french:    return "FR"
            case .german:    return "DE"
            case .spanish:   return "ES"
            case .ukrainian: return "УК"
            }
        }
        
        var filePrefix: String {
            switch self {
            case .english:   return "EN"
            case .russian:   return "RU"
            case .czech:     return "CZ"
            case .polish:    return "PL"
            case .french:    return "FR"
            case .german:    return "DE"
            case .spanish:   return "ES"
            case .ukrainian: return "UA"
            }
        }
        
        var officialName: String {
            switch self {
            case .english:   return "en"
            case .russian:   return "ru"
            case .czech:     return "cs"
            case .polish:    return "pl"
            case .french:    return "fr"
            case .german:    return "de"
            case .spanish:   return "es"
            case .ukrainian: return "uk"
            }
        }
        
        static func shortName(for officialName: String) -> String {
            return LocaleItem.allCases.first(where: { $0.officialName.lowercased() == officialName.lowercased() })?.shortName ?? "EN"
        }
        
        static func filePrefix(for officialName: String) -> String {
            return LocaleItem.allCases.first(where: { $0.officialName.lowercased() == officialName.lowercased() })?.filePrefix ?? "EN"
        }
    }
    
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var theme: ThemeManager
    
    @AppStorage("appLanguage") var language: String = "ru"
    
    @State var currentLocale: LocaleItem = .russian
    
    let allLocales: [LocaleItem] = [.english, .russian, .czech, .polish, .french, .german, .spanish, .ukrainian]
    
    var body: some View{
        NavigationStack {
            VStack {
                ForEach(allLocales, id: \.self) { locale in
                    NG_Button(title: locale.fullName, style: .NG_ButtonStyle_Regular, isDisabled: .constant(locale != currentLocale), isHighlighting: .constant(false), isPulsating: .constant(false), action: {
                        Settings.setLocale(locale.officialName, in: viewContext)
                        language = locale.officialName
                        refetchLocale()
                    }, widthFlood: true)
                    .padding(.horizontal)
                    /*
                    Button(action: {
                        Settings.setLocale(locale.officialName, in: viewContext)
                        language = locale.officialName
                        refetchLocale()
                    }) {
                        Text(locale.fullName)
                            .frame(maxWidth: .infinity)
                            .customButtonStyle(type: .neutral, isActive: locale == currentLocale)
                    }
                     */
                }
                Spacer()
            }
            .onAppear{
                refetchLocale()
            }
            .background(theme.currentTheme.NG_LinearGradient_Background_Page)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(
                leading: /*Button(action: {
                    dismiss()
                }) {*/
                    BackButton(action: {
                        dismiss()
                    })
                //}
            )
        }
    }
    
    func refetchLocale(){
        let currentLocaleShort = Settings.getLocale(in: viewContext)
        
        if let found = LocaleItem.allCases.first(where: { $0.officialName == currentLocaleShort }) {
            currentLocale = found
        } else{
            currentLocale = .english
        }
    }
}
