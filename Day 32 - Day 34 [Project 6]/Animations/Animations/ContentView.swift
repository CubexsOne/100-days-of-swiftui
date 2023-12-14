//
//  ContentView.swift
//  Animations
//
//  Created by Pascal Sauer on 14.12.23.
//

import SwiftUI

struct ContentView: View {
    @State private var animationAmount = 0.0

    var body: some View {
        Button("Tap Me") {
            withAnimation(.spring(duration: 1, bounce: 0.5)) {
                animationAmount += 360
            }
        }
        .padding(50)
        .background(.red)
        .foregroundStyle(.white)
        .clipShape(.circle)
        .rotation3DEffect(
            .degrees(animationAmount),
            axis: (x: 0.0, y: 1.0, z: 1.0)
        )
    }
}

#Preview {
    ContentView()
}
