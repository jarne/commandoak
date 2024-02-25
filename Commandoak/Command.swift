//
//  Command.swift
//  Commandoak
//

import Foundation
import SwiftData

@Model
final class Command {
    var name: String
    var icon: String
    var execute: String
    
    init(name: String = "New command", icon: String = "🕹️", execute: String = "") {
        self.name = name
        self.icon = icon
        self.execute = execute
    }
}
