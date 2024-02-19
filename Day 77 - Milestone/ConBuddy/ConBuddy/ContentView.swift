//
//  ContentView.swift
//  ConBuddy
//
//  Created by Pascal Sauer on 19.02.24.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Query private var buddies: [Buddy]
    @State private var showEditView = false

    var body: some View {
        NavigationStack {
            List {
                if buddies.isEmpty {
                    Button("Add new buddy") {
                        showEditView = true
                    }
                    .frame(maxWidth: .infinity)
                } else {
                    ForEach(buddies) { buddy in
                        Text(buddy.firstName)
                    }
                }
            }
            .scrollBounceBehavior(.basedOnSize)
            .buttonStyle(.plain)
            .navigationTitle("ConBuddy")
            .toolbar {
                Button("Add new buddy", systemImage: "plus") {
                    showEditView = true
                }
            }
            .sheet(isPresented: $showEditView) {
                BuddyAddView()
            }
        }
    }
}

#Preview {
    ContentView()
}
