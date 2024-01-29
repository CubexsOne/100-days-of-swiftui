//
//  ContentView.swift
//  iExpense
//
//  Created by Pascal Sauer on 18.12.23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            List {
                ForEach(types, id:\.self) {
                    ListFilteredByType(type: $0)
                }
            }
            .navigationTitle("iExpense")
            .toolbar {
                NavigationLink {
                    AddView()
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
