//
//  ListView.swift
//  FriendFace
//
//  Created by Pascal Sauer on 30.01.24.
//

import SwiftData
import SwiftUI

struct ListView: View {
    @Query private var users: [User]

    var body: some View {
        List(users) { user in
            NavigationLink(value: user.id) {
                HStack {
                    UserIcon(name: user.name)
                    VStack(alignment: .leading) {
                        Text(user.name)
                        Text("Registered: \(user.formattedRegistrationDate)")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                }
            }
        }
    }
    
    init(_ sortOrder: [SortDescriptor<User>]) {
        _users = Query(sort: sortOrder)
    }
}

#Preview {
    ListView([SortDescriptor(\User.name, order: .forward)])
        .modelContainer(for: User.self)
}
