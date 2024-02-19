//
//  BuddyListItem.swift
//  ConBuddy
//
//  Created by Pascal Sauer on 19.02.24.
//

import SwiftData
import SwiftUI

struct BuddyListItem: View {
    let buddy: Buddy
    var body: some View {
        NavigationLink(value: buddy) {
            HStack {
                buddy.potrait
                    .resizable()
                    .scaledToFill()
                    .frame(width: 56, height: 56)
                    .clipShape(.capsule)
                Text("\(buddy.lastName), \(buddy.firstName)")
            }
        }
    }
}

//#Preview {
//    BuddyListItem(buddy: Buddy(firstName: "", lastName: "", image: Data()))
//        .modelContainer(for: Buddy.self)
//}
