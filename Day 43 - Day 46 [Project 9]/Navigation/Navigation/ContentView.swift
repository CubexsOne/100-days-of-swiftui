//
//  ContentView.swift
//  Navigation
//
//  Created by Pascal Sauer on 26.12.23.
//

import SwiftUI

struct ContentView: View {
    @State private var title = "SwiftUI"

    var body: some View {
        NavigationStack {
            Text("Der Titel lautet: \(title)")
                .navigationTitle($title)
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    ContentView()
}
