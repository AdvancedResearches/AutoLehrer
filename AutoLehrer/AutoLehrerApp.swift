//
//  AutoLehrerApp.swift
//  AutoLehrer
//
//  Created by Алексей Хурсевич on 28.07.25.
//

import SwiftUI

@main
struct AutoLehrerApp: App {
    let persistenceController = PersistenceController.shared
    
    @StateObject private var theme: ThemeManager
    @StateObject private var recommendationModel = RecommendationModel()
    
    init() {
        let context = PersistenceController.shared.container.viewContext
        _theme = StateObject(wrappedValue: ThemeManager(context: context))
    }

    var body: some Scene {
        WindowGroup {
            MainMenu()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environment(\.appLanguage, Settings.getLocale(in: persistenceController.container.viewContext))
                .environmentObject(theme)
                .environmentObject(recommendationModel)
        }
    }
}
