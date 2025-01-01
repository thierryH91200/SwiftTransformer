//
//  SwiftTransformerApp.swift
//  SwiftTransformer
//
//  Created by Thierry hentic on 13/11/2024.
//

import SwiftUI
import SwiftData

@main
struct SwiftTransformerApp: App {
    
    @NSApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    init() {
        // Enregistrer le ValueTransformer pour la couleur
        ColorTransformer.register()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: EntityModel.self)
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {
    
    func applicationWillFinishLaunching(_ notification: Notification) {
    }
    
    func applicationDidFinishLaunching(_ notification: Notification) {
    }
    
    func applicationShouldTerminateAfterLastWindowClosed (_ sender: NSApplication) -> Bool {
        return true
    }
}

func getSQLiteFilePath() -> String? {
    guard FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).last != nil else { return nil}

    if let url = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first {
        let path = "Data Store file is located at: \(url.path)"
        return path
    }
    return nil
}

