//
//  SettingsView.swift
//  Commandoak
//

import SwiftUI
import SwiftData
import ServiceManagement
import OSLog

struct SettingsView: View {
    @State private var autostart: Bool = false
    
    var body: some View {
        Form {
            Toggle("Start on login", isOn: $autostart)
                .onChange(of: autostart, save)
                .padding()
        }
        .onAppear(perform: load)
    }
    
    func load() {
        let service = SMAppService.loginItem(identifier: "rocks.jarne.CommandoakLoginHelper")
        let status = service.status.rawValue
        
        if status == SMAppService.Status.enabled.rawValue {
            autostart = true
        } else {
            autostart = false
        }
    }
        
    func save() {
        registerAutostart(enabled: autostart)
    }
    
    func registerAutostart(enabled: Bool) {
        let service = SMAppService.loginItem(identifier: "rocks.jarne.CommandoakLoginHelper")
        
        if enabled {
            do {
                try service.register()
            } catch {
                Logger().error("Couldn't register login service: \(error)")
            }
        } else {
            do {
                try service.unregister()
            } catch {
                Logger().error("Couldn't unregister login service: \(error)")
            }
        }
        
        load()
    }
}

#Preview {
    SettingsView()
}
