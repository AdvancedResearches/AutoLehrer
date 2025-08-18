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
        let ctx = PersistenceController.shared.container.viewContext
        _theme = StateObject(wrappedValue: ThemeManager(context: ctx))
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
                        try? await Task.sleep(nanoseconds: 500_000_000) // задержка 0.5 секунды
                        await presetLoad()   // ждём тут
                        isActive = true
                    }
            }
        }
    }
    
    // Запускаем импорт на фоновом MOC, UI обновляем через MainActor
        func presetLoad() async {
            presetsProgress.reset()
            presetsProgress.text = "Начато обновление базы слов…"

            let bg = persistenceController.container.newBackgroundContext()

            guard
                let dir = Bundle.main.resourceURL,
                let files = Bundle.main.urls(forResourcesWithExtension: "alpres", subdirectory: nil)
            else {
                presetsProgress.text = "Файлы пресетов не найдены"
                presetsProgress.completed = true
                return
            }

            let sorted = files.sorted { $0.lastPathComponent < $1.lastPathComponent }
            let total = max(sorted.count, 1)

            for (i, url) in sorted.enumerated() {
                let fileURL = dir.appendingPathComponent(url.lastPathComponent)

                do {
                    try await bg.perform {
                        let ok = Data_Archival(theFile: fileURL, theContext: bg)
                            .preset(progress: presetsProgress, index: i + 1, total: total)
                        if ok { try? bg.save() }
                    }
                } catch {
                    // perform может кинуть, если MOC умер — логируем и идём дальше
                    Task { @MainActor in
                        presetsProgress.text = "Ошибка: \(url.lastPathComponent)"
                    }
                }
            }

            presetsProgress.text = "Обновление базы слов закончено!"
            presetsProgress.fraction = 1
            presetsProgress.completed = true
        }
}
