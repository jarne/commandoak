//
//  Command.swift
//  Commandoak
//

import Foundation
import SwiftData

@Model
final class Command {
    static let defaultName = "New command"
    static let defaultIcon = "🕹️"
    static let defaultExecute = ""
    static let defaultPosition = 0
    
    var name: String = defaultName
    var icon: String = defaultIcon
    var execute: String = defaultExecute
    var position: Int = defaultPosition

    init(name: String = defaultName, icon: String = defaultIcon, execute: String = defaultExecute, position: Int = defaultPosition) {
        self.name = name
        self.icon = icon
        self.execute = execute
        self.position = position
    }
}
