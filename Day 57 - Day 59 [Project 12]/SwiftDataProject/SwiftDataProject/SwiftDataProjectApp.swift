//
//  SwiftDataProjectApp.swift
//  SwiftDataProject
//
//  Created by Pascal Sauer on 26.01.24.
//

import SwiftData
import SwiftUI

@main
struct SwiftDataProjectApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: User.self)
    }
}
