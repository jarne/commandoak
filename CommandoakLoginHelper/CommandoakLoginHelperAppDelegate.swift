//
//  CommandoakLoginHelperAppDelegate.swift
//  CommandoakLoginHelper
//

import Cocoa

class CommandoakLoginHelperAppDelegate: NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(_: Notification) {
        let runningApps = NSWorkspace.shared.runningApplications
        let isRunning = runningApps.contains { app in
            app.bundleIdentifier == "rocks.jarne.Commandoak"
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
