//
//  SwiftTransformerApp.swift
//  SwiftTransformer
//
//  Created by Thierry hentic on 13/11/2024.
//

import SwiftUI
import SwiftData
import UniformTypeIdentifiers


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

//    var body: some Scene {
//        DocumentGroup(editing: .itemDocument, migrationPlan: SwiftTransformerMigrationPlan.self) {
//            ContentView()
//        }
//    }
}


extension UTType {
    static var itemDocument: UTType {
        UTType(importedAs: "com.example.item-document")
    }
}

struct SwiftTransformerMigrationPlan: SchemaMigrationPlan {
    static var schemas: [VersionedSchema.Type] = [
        SwiftTransformerVersionedSchema.self,
    ]

    static var stages: [MigrationStage] = [
        // Stages of migration between VersionedSchema, if required.
    ]
}

struct SwiftTransformerVersionedSchema: VersionedSchema {
    static var versionIdentifier = Schema.Version(1, 0, 0)

    static var models: [any PersistentModel.Type] = [
        EntityModel.self,
    ]
}

class AppDelegate: NSObject, NSApplicationDelegate {
    
    var splashScreenWindowController: SplashScreenWindowController! = nil

    func applicationWillFinishLaunching(_ notification: Notification) {
//        splashScreenWindowController = SplashScreenWindowController()
//        splashScreenWindowController.showWindow(self)
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

