//
//  ContentView.swift
//  HotProspects
//
//  Created by Pascal Sauer on 23.02.24.
//

import SwiftUI

struct ContentView: View {
    @State private var backgroundColor = Color.red
    
    var body: some View {
        VStack {
            Text("Hello, world!")
                .padding()
                .background(backgroundColor)
            
            Text("Change Color")
                .padding()
                .contextMenu {
                    Button("Red", systemImage: "checkmark.circle.fill") {
                        backgroundColor = .red
                    }
                    .foregroundStyle(.red)
                    
                    Button("Green") {
                        backgroundColor = .green
                    }
                    
                    Button("Blue") {
                        backgroundColor = .blue
                    }
                }
        }
    }
}

#Preview {
    ContentView()
}
