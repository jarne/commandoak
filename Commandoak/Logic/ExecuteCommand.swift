//
//  ExecuteCommand.swift
//  Commandoak
//

import AppKit
import Foundation

class ExecuteCommand {
    static func runCommand(command: String) {
        switch AppSettings.terminalApp {
        case .appleTerminal:
            runCommandInSystemTerminal(command: command)
        case .ghostty:
            runCommandInGhostty(command: command)
        }
    }

    private static func runCommandInSystemTerminal(command: String) {
        guard let url = NSWorkspace.shared.urlForApplication(withBundleIdentifier: TerminalApp.appleTerminal.id) else {
            print("Cannot find Terminal application")
            return
        }

        let conf = NSWorkspace.OpenConfiguration()

        let event = NSAppleEventDescriptor(
            eventClass: kAECoreSuite,
            eventID: kAEDoScript,
            targetDescriptor: nil,
            returnID: AEReturnID(kAutoGenerateReturnID),
            transactionID: AETransactionID(kAnyTransactionID)
        )
        event.setParam(NSAppleEventDescriptor(string: command), forKeyword: keyDirectObject)
        conf.appleEvent = event

        NSWorkspace.shared.openApplication(at: url, configuration: conf)
    }

    private static func fourCharCode(_ string: String) -> FourCharCode {
        string.utf8.reduce(0) { ($0 << 8) | FourCharCode($1) }
    }

    private static func runCommandInGhostty(command: String) {
        guard let url = NSWorkspace.shared.urlForApplication(withBundleIdentifier: TerminalApp.ghostty.id) else {
            print("Cannot find Ghostty application")
            return
        }

        let conf = NSWorkspace.OpenConfiguration()

        let surfaceConfig = NSAppleEventDescriptor.record()
        // scripting codes documented here: https://github.com/ghostty-org/ghostty/blob/main/macos/Ghostty.sdef
        surfaceConfig.setDescriptor(NSAppleEventDescriptor(string: command + "\n"), forKeyword: fourCharCode("GScI"))

        let event = NSAppleEventDescriptor(
            eventClass: fourCharCode("Ghst"),
            eventID: fourCharCode("NWin"),
            targetDescriptor: nil,
            returnID: AEReturnID(kAutoGenerateReturnID),
            transactionID: AETransactionID(kAnyTransactionID)
        )
        event.setParam(surfaceConfig, forKeyword: fourCharCode("GNwS"))
        conf.appleEvent = event

        NSWorkspace.shared.openApplication(at: url, configuration: conf)
    }
}
