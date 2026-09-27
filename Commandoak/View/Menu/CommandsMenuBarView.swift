//
//  CommandsMenuBarView.swift
//  Commandoak
//

import SwiftData
import SwiftUI

struct CommandsMenuBarView: View {
    @Environment(\.openWindow) private var openWindow

    @Query(sort: \Command.position) private var commands: [Command]

    var body: some View {
        ForEach(Array(commands.enumerated()), id: \.offset) { index, cmd in
            self.renderCommand(index: index, cmd: cmd)
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
    private func renderCommand(index: Int, cmd: Command) -> some View {
        let kbShortcut = findKBShortcutForI(index: index)

        if kbShortcut != nil {
            Button("\(cmd.icon) \(cmd.name)") {
                ExecuteCommand.runCommand(command: cmd.execute)
            }
            .keyboardShortcut(kbShortcut)
        } else {
            Button("\(cmd.icon) \(cmd.name)") {
                ExecuteCommand.runCommand(command: cmd.execute)
            }
        }
    }

    private func findKBShortcutForI(index: Int) -> KeyboardShortcut? {
        switch index {
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
}

#Preview {
    CommandsMenuBarView()
        .modelContainer(for: Command.self, inMemory: true)
}
