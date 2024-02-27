//
//  CommandsMenuBarView.swift
//  Commandoak
//

import SwiftUI
import SwiftData

struct CommandsMenuBarView: View {
    @Environment(\.openWindow) private var openWindow
    
    @Query private var commands: [Command]
    
    var body: some View {
        ForEach(commands) { cmd in
            Button("\(cmd.icon) \(cmd.name)") {
                runCommand(command: cmd.execute)
            }
        }
        Divider()
        Button("Commands") {
            openWindow(id: "commands")
        }
        .keyboardShortcut("c")
        Button("Settings") {
            openWindow(id: "settings")
        }
        .keyboardShortcut("s")
        Button("Quit") {
            NSApplication.shared.terminate(self)
        }
        .keyboardShortcut("q")
    }
    
    private func runCommand(command: String) {
        guard let url = NSWorkspace.shared.urlForApplication(withBundleIdentifier: "com.apple.Terminal") else {
            print("Cannot find Terminal application")
            
            return
        }
        
        let conf = NSWorkspace.OpenConfiguration()
        
        let event = NSAppleEventDescriptor(eventClass: kAECoreSuite, eventID: kAEDoScript, targetDescriptor: nil, returnID: AEReturnID(kAutoGenerateReturnID), transactionID: AETransactionID(kAnyTransactionID))
        event.setParam(NSAppleEventDescriptor(string: command), forKeyword: keyDirectObject)
        conf.appleEvent = event
        
        NSWorkspace.shared.openApplication(at: url, configuration: conf)
    }
}

#Preview {
    CommandsMenuBarView()
        .modelContainer(for: Command.self, inMemory: true)
}
