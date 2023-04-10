//
//  GreenThumbsDividerApp.swift
//  GreenThumbsDivider
//
//  Created by Павло Сніжко on 10.04.2023.
//

import SwiftUI

@main
struct GreenThumbsDividerApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
