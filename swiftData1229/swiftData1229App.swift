//
//  swiftData1229App.swift
//  swiftData1229
//
//  Created by imac-2627 on 2023/12/29.
//

import SwiftUI
import SwiftData

@main
struct swiftData1229App: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            URLDemoView()
        }
        .modelContainer(sharedModelContainer)
    }
}
