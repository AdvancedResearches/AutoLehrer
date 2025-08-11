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
                    .environmentObject(presetsProgress)
                    .task {
                        // Запускаем загрузку прямо на лонч-скрине
                        await presetLoad()
                        isActive = true // переход только после окончания загрузки
                    }
                    /*
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            isActive = true // Через 2 сек. показываем главный экран
                        }
                    }
                     */
            }
        }
    }
    
    @MainActor
    func presetLoad() async {
        presetsProgress.text = "Начато обновление базы слов..."

        let fileDirectory: URL? = Bundle.main.resourceURL
        if let presetFiles = Bundle.main.urls(forResourcesWithExtension: "alpres", subdirectory: nil) {
            for fileURL in presetFiles.sorted(by: { $0.lastPathComponent < $1.lastPathComponent }) {
                presetsProgress.text = "Загружаем \(fileURL.lastPathComponent)..."
                
                // performAndWait — блокирует текущий поток, поэтому оборачиваем в Task
                await persistenceController.container.viewContext.perform {
                    Data_Archival(
                        theFile: fileDirectory!.appendingPathComponent(fileURL.lastPathComponent),
                        theContext: persistenceController.container.viewContext
                    ).preset()
                    
                    do {
                        try persistenceController.container.viewContext.save()
                    } catch {
                        print("Ошибка сохранения: \(error.localizedDescription)")
                    }
                }
            }
        }

        presetsProgress.text = "Обновление базы слов закончено!"
    }
}
