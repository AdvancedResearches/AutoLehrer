//
//  AutoLehrerApp.swift
//  AutoLehrer
//
//  Created by Алексей Хурсевич on 28.07.25.
//

import SwiftUI

class PresetsProgressOO: ObservableObject {
    @Published var text: String = "Запускаемся..."
}

@main
struct AutoLehrerApp: App {
    let persistenceController = PersistenceController.shared
    
    @State private var isActive = false
    
    @StateObject private var theme: ThemeManager
    @StateObject private var recommendationModel = RecommendationModel()
    @StateObject private var presetsProgress = PresetsProgressOO()
    
    init() {
        let context = PersistenceController.shared.container.viewContext
        _theme = StateObject(wrappedValue: ThemeManager(context: context))
    }
    
    var body: some Scene {
        WindowGroup {
            if isActive {
                MainMenu()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
                    .environment(\.appLanguage, Settings.getLocale(in: persistenceController.container.viewContext))
                    .environmentObject(theme)
                    .environmentObject(recommendationModel)
                    .environmentObject(presetsProgress)
            }else{
                LaunchScreen()
                    .environmentObject(theme)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            isActive = true // Через 2 сек. показываем главный экран
                        }
                    }
            }
        }
    }
}
