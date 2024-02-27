//
//  CommandoakLoginHelperAppDelegate.swift
//  CommandoakLoginHelper
//

import Cocoa

class CommandoakLoginHelperAppDelegate: NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(_ notification: Notification) {
        let runningApps = NSWorkspace.shared.runningApplications
        let isRunning = runningApps.contains { app in
            return app.bundleIdentifier == "rocks.jarne.Commandoak"
        }
        
        if isRunning {
            return
        }
        
        var path = Bundle.main.bundlePath as NSString
        path = path.deletingLastPathComponent as NSString
        path = path.deletingLastPathComponent as NSString
        path = path.deletingLastPathComponent as NSString
        path = path.deletingLastPathComponent as NSString
        
        let url = URL(filePath: path as String)
        NSWorkspace.shared.open(url, configuration: NSWorkspace.OpenConfiguration())
    }
}
