//
//  InventoryApp.swift
//  Inventory
//
//  Created by Sean Grady on 11/24/23.
//

import SwiftUI

@main
struct InventoryApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
