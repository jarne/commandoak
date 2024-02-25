//
//  CommandoakApp.swift
//  Commandoak
//

import SwiftUI
import SwiftData

@main
struct CommandoakApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Command.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    var body: some Scene {
        WindowGroup {
            CommandsView()
        }
        .modelContainer(sharedModelContainer)
        MenuBarExtra("Commandoak") {
            CommandsMenuBarView()
                .modelContainer(sharedModelContainer)
        }
    }
}
