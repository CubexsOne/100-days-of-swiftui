//
//  ActivityNavLink.swift
//  Habbit-Tracker
//
//  Created by Pascal Sauer on 15.01.24.
//

import SwiftUI

struct ActivityNavLink: View {
    let activity: Activity

    var body: some View {
        NavigationLink {
            ActivityDetailView(activity: activity)
        } label: {
            HStack {
                Image(systemName: getImage(by: activity.type))
                Text(activity.description)
            }
        }
    }
    
    func getImage(by type: ActivityType) -> String {
        switch (type) {
        case .sport:
            return "sportscourt.circle"
        case .learning:
            return "books.vertical.circle"
        case .practicing:
            return "scissors.circle"
        case .other:
            return "ellipsis.circle"
        }
    }
}
