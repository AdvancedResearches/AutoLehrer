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
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
