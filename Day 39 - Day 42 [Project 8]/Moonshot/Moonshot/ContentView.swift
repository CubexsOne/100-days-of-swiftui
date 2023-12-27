//
//  ContentView.swift
//  Moonshot
//
//  Created by Pascal Sauer on 21.12.23.
//

import SwiftUI

struct ContentView: View {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    @State private var showingAsGrid = true
    var buttonText: String {
        showingAsGrid ? "List" : "Grid"
    }

    var body: some View {
        NavigationStack {
            ZStack {
                if showingAsGrid {
                    MissionGrid(astronauts: astronauts, missions: missions)
                } else {
                    MissionList(astronauts: astronauts, missions: missions)
                }
            }
            .navigationTitle("Moonshot")
            .background(.darkBackground)
            .preferredColorScheme(.dark)
            .toolbar {
                Button("Switch to \(buttonText)") {
                    showingAsGrid.toggle()
                }
                .foregroundColor(.white)
            }
        }
    }
}

#Preview {
    ContentView()
}
