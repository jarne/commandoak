//
//  AppSettings.swift
//  Commandoak
//

import Foundation

enum TerminalApp: String, CaseIterable, Identifiable {
    case appleTerminal = "com.apple.Terminal"
    case ghostty = "com.mitchellh.ghostty"

    var id: String {
        rawValue
    }

    var displayName: String {
        switch self {
        case .appleTerminal:
            return "Apple Terminal"
        case .ghostty:
            return "Ghostty"
        }
    }
}

enum AppSettings {
    static let terminalAppKey = "terminalApp"
    static let defaultTerminalApp = TerminalApp.appleTerminal

    static var terminalApp: TerminalApp {
        get {
            UserDefaults.standard.string(forKey: terminalAppKey)
                .flatMap(TerminalApp.init(rawValue:)) ?? defaultTerminalApp
        }
        set {
            UserDefaults.standard.set(newValue.rawValue, forKey: terminalAppKey)
        }
    }
}
