//
//  ActivityDetailView.swift
//  Habbit-Tracker
//
//  Created by Pascal Sauer on 15.01.24.
//

import SwiftUI

struct ActivityDetailView: View {
    @State var activity: Activity
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Category") {
                    Text(activity.type.rawValue)
                }
                
                Section("Duration") {
                    Text("\(activity.duration, format: .number)")
                }
                
                Section("Done at") {
                    Text(activity.formattedLaunchDate)
                }
            }
            .navigationTitle("Activity: \(activity.description)")
            .navigationBarTitleDisplayMode(.inline)            
        }
    }
}

#Preview {
    let activity = Activity(id: UUID(), description: "", created: .now, duration: 12, type: .other)
    return ActivityDetailView(activity: activity)
}
