//
//  RollDiceApp.swift
//  RollDice
//
//  Created by Pascal Sauer on 18.03.24.
//

import SwiftUI
import SwiftData

@main
struct RollDiceApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: RollsResult.self)
    }
}
