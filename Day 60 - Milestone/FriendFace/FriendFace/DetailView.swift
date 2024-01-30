//
//  DetailView.swift
//  FriendFace
//
//  Created by Pascal Sauer on 30.01.24.
//

import SwiftData
import SwiftUI

struct DetailView: View {
    @Environment(\.dismiss) var dismiss
    @Query private var users: [User]
    @State private var showingAlert = false
    
    var user: User {
        users.first!
    }

    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    VStack {
                        UserIcon(name: user.name, size: 192, fontSize: 72)
                            .padding(.bottom, 16)
                        Text(user.name)
                            .font(.title)
                            .foregroundStyle(.white)
                            .padding(.bottom, 8)
                        Text(user.email)
                            .font(.subheadline)
                            .foregroundStyle(.white)
                        Text("Registered: \(user.formattedRegistrationDate)")
                            .font(.subheadline)
                            .foregroundStyle(.white)
                            .padding(.bottom, 16)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.top, 96)
                    .background(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                Color(red: 0.95, green: 0.95, blue: 0.95),
                                Color(red: 0.5, green: 0.5, blue: 0.5)
                            ]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing)
                    )
                }
                .padding(.bottom, 16)
                
                DetailViewTextBox(title: "About", content: user.about)
                DetailViewTextBox(title: "Address", content: user.address)
                
                VStack {
                    Text("Friends:")
                    ScrollView(.horizontal) {
                        HStack(alignment: .center) {
                            ForEach(user.friends ?? []) { friend in
                                NavigationLink(value: friend.id) {
                                    UserIcon(name: friend.name)
                                }
                            }
                        }
                    }
                }
                
                Spacer()
            }
        }
        .scrollBounceBehavior(.basedOnSize)
        .ignoresSafeArea()
        .alert("User not found!", isPresented: $showingAlert) {
            Button("Ok") {
                dismiss()
            }
        } message: {
            Text("Can't find user")
        }
    }
    
    init(id: UUID) {
        _users = Query(filter: #Predicate<User> { user in
            user.id == id
        })
    }
    
    func checkUserExisting() {
        guard users.first != nil else {
            showingAlert = true
            return
        }
    }
}

#Preview {
    DetailView(id: UUID())
        .modelContainer(for: User.self)
}
