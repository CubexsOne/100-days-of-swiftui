//
//  ContentView.swift
//  Habbit-Tracker
//
//  Created by Pascal Sauer on 15.01.24.
//

import SwiftUI

struct ContentView: View {
    @State private var activities = Activities()
    @State private var showAddView = false

    var body: some View {
        NavigationStack {
            List {
                ForEach(activities.list) { activity in
                    ActivityNavLink(activity: activity)
                }.onDelete(perform: { indexSet in
                    activities.list.remove(atOffsets: indexSet)
                })
            }
            .navigationTitle("Habbit-Tracker")
            .toolbar {
                Button {
                    showAddView = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showAddView) {
                ActivityAddView(activities: activities)
            }
        }
    }
}

#Preview {
    ContentView()
}
