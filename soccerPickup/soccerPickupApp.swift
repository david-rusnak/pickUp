//
//  soccerPickupApp.swift
//  soccerPickup
//
//  Created by David Rusnak on 12/3/22.
//

import SwiftUI

@main
struct soccerPickupApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
