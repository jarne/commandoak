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
            Command.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        MenuBarExtra("Commandoak", systemImage: "command") {
            CommandsMenuBarView()
                .modelContainer(sharedModelContainer)
        }
        Group {
            Window("Commands", id: "commands") {
                CommandsView()
            }
            Window("Settings", id: "settings") {
                SettingsView()
            }
        }
        .modelContainer(sharedModelContainer)
    }
}
