//
//  ConBuddyApp.swift
//  ConBuddy
//
//  Created by Pascal Sauer on 19.02.24.
//

import SwiftData
import SwiftUI

@main
struct ConBuddyApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Buddy.self)
    }
}
