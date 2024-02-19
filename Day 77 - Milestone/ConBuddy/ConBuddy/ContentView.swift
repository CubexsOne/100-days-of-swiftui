//
//  ContentView.swift
//  ConBuddy
//
//  Created by Pascal Sauer on 19.02.24.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
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
                        BuddyListItem(buddy: buddy)
                    }
                    .onDelete(perform: deleteBuddy)
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
            .navigationDestination(for: Buddy.self) { buddy in
                VStack {
                    buddy.potrait
                        .resizable()
                        .scaledToFit()
                    Text("\(buddy.lastName), \(buddy.firstName)")
                    Spacer()
                }
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
    
    func deleteBuddy(offsets: IndexSet) {
        for index in offsets {
            let modelToDelete = buddies[index]
            modelContext.delete(modelToDelete)
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Buddy.self)
}
