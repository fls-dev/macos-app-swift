//
//  AppDelegate.swift
//  macos-app-swift
//
//  Created by Pavel Misko on 16.11.22.
//

import Cocoa

@main

class AppDelegate: NSObject, NSApplicationDelegate {

    
    var statusBarItem: NSStatusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)

       func applicationDidFinishLaunching(_ aNotification: Notification) {
           guard let statusButton = statusBarItem.button else { return }
           statusButton.title = "Advanced Clock"
       }
//
//    func applicationDidFinishLaunching(_ aNotification: Notification) {
//        // Insert code here to initialize your application
//    }
//
//    func applicationWillTerminate(_ aNotification: Notification) {
//        // Insert code here to tear down your application
//    }
//
//    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
//        return true
//    }


}

