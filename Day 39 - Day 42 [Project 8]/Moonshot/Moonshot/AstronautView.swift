//
//  AstronautView.swift
//  Moonshot
//
//  Created by Pascal Sauer on 23.12.23.
//

import SwiftUI

struct AstronautView: View {
    let astronaut: Astronaut

    var body: some View {
        ScrollView {
            VStack {
                Image(decorative: astronaut.id)
                    .resizable()
                    .scaledToFit()
                    .accessibilityLabel("Image of astronaut \(astronaut.name)")
                
                Text(astronaut.description)
                    .padding()
            }
        }
        .background(.darkBackground)
        .navigationTitle(astronaut.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    
    return AstronautView(astronaut: astronauts["armstrong"]!)
        .preferredColorScheme(.dark)
}
