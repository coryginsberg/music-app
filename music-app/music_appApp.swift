//
//  music_appApp.swift
//  music-app
//
//  Created by Cory Ginsberg on 1/13/23.
//

import SwiftUI

@main
struct music_appApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
