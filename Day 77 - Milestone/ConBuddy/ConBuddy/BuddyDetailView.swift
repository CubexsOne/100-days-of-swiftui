//
//  BuddyDetailView.swift
//  ConBuddy
//
//  Created by Pascal Sauer on 20.02.24.
//

import SwiftUI

struct BuddyDetailView: View {
    let buddy: Buddy
    var body: some View {
        buddy.potrait
            .resizable()
            .scaledToFit()
        Form {
            Section("Personal Data") {
                Text("First name")
                Text("Last name")
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .scrollBounceBehavior(.basedOnSize)
    }
}
