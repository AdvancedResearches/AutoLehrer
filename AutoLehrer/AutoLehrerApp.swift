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

    var body: some Scene {
        WindowGroup {
            MainMenu()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

/*
 var body: some Scene {
     WindowGroup {
         if isActive {
             MainMenu()
                 .environment(\.managedObjectContext, persistenceController.container.viewContext)
                 .environment(\.appLanguage, Settings.getLocale(in: persistenceController.container.viewContext))
                 .environmentObject(theme)
                 .onAppear {
                     DBSanityCheckAndFix()
                 }
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
 */
