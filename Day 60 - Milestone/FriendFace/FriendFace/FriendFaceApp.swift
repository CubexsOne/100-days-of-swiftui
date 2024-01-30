//
//  FriendFaceApp.swift
//  FriendFace
//
//  Created by Pascal Sauer on 30.01.24.
//

import SwiftData
import SwiftUI

@main
struct FriendFaceApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: User.self)
    }
}
