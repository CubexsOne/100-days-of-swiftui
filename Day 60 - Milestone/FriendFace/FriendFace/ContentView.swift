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
    @Query var users: [User]

    var body: some View {
        NavigationStack {
            List(users) { user in
                VStack {
                    Text("Name: \(user.name)")
                    if user.unwrappedFriends.count > 0 {
                        Text("Friend: \(user.friends?[0].name ?? "NotFound")")
                    }
                }
            }
            .task {
                await retrieveUser()
            }
        }
    }
    
    func retrieveUser() async {
        try? modelContext.delete(model: User.self)
        
        do {
            let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let decodedResponse = try decoder.decode([User].self, from: data)
            
            try modelContext.transaction {
                decodedResponse.forEach { user in
                    modelContext.insert(user)
                }
                
                modelContext.autosaveEnabled = false
                do {
                    try modelContext.save()
                } catch {
                    print("Error during saving users: \(error.localizedDescription)")
                }
                modelContext.autosaveEnabled = true
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
