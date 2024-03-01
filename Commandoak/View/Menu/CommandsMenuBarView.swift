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
        ForEach(Array(commands.enumerated()), id: \.offset) { i, cmd in
            self.renderCommand(i: i, cmd: cmd)
        }
        Divider()
        Button("Commands") {
            openWindow(id: "commands")
        }
        Button("Settings") {
            openWindow(id: "settings")
        }
        .keyboardShortcut(",")
        Button("Quit") {
            NSApplication.shared.terminate(self)
        }
        .keyboardShortcut("q")
    }

    @ViewBuilder
    private func renderCommand(i: Int, cmd: Command) -> some View {
        let kbShortcut = findKBShortcutForI(i: i)

        if kbShortcut != nil {
            Button("\(cmd.icon) \(cmd.name)") {
                runCommand(command: cmd.execute)
            }
            .keyboardShortcut(kbShortcut)
        } else {
            Button("\(cmd.icon) \(cmd.name)") {
                runCommand(command: cmd.execute)
            }
        }
    }

    private func findKBShortcutForI(i: Int) -> KeyboardShortcut? {
        switch i {
        case 0:
            return KeyboardShortcut("1")
        case 1:
            return KeyboardShortcut("2")
        case 2:
            return KeyboardShortcut("3")
        case 3:
            return KeyboardShortcut("4")
        case 4:
            return KeyboardShortcut("5")
        case 5:
            return KeyboardShortcut("6")
        case 6:
            return KeyboardShortcut("7")
        case 7:
            return KeyboardShortcut("8")
        case 8:
            return KeyboardShortcut("9")
        default:
            return nil
        }
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
