//
//  ContentView.swift
//  FriendFace
//
//  Created by Pascal Sauer on 30.01.24.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @State private var initialized = false
    @State private var path = [UUID]()
    @State private var sortOrder = [
        SortDescriptor(\User.name, order: .forward),
        SortDescriptor(\User.registered)
    ]

    var body: some View {
        NavigationStack(path: $path) {
            ListView(sortOrder)
            .onAppear(perform: {
                Task {
                    await retrieveUser()
                }
            })
            .navigationTitle("FriendFace")
            .navigationDestination(for: UUID.self) { value in
                DetailView(id: value)
            }
            .toolbar {
                Menu("Sort alphabetical", systemImage: "arrow.up.arrow.down") {
                    Picker("Sort alphabetical", selection: $sortOrder) {
                        Text("ASC")
                            .tag([
                                SortDescriptor(\User.name, order: .forward),
                                SortDescriptor(\User.registered)
                            ])
                        
                        Text("DESC")
                            .tag([
                                SortDescriptor(\User.name, order: .reverse),
                                SortDescriptor(\User.registered)
                            ])
                    }
                }
            }
        }
        .accentColor(.black)
    }
    
    func retrieveUser() async {
        if (initialized) { return }
        try? modelContext.delete(model: User.self)
        
        do {
            let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let decodedResponse = try decoder.decode([User].self, from: data)
            
            modelContext.autosaveEnabled = false
            try modelContext.transaction {
                decodedResponse.forEach { user in
                    modelContext.insert(user)
                }
                
                do {
                    try modelContext.save()
                } catch {
                    print("Error during saving users: \(error.localizedDescription)")
                }
                modelContext.autosaveEnabled = true
                initialized = true
            }
            
        } catch {
            print("Error during retrieving user: \(error.localizedDescription)")
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: User.self)
}
