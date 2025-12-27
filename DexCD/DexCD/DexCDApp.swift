//
//  DexCDApp.swift
//  DexCD
//
//  Created by Nagaraju on 27/12/25.
//

import SwiftUI
import CoreData

@main
struct DexCDApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
