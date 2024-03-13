//
//  ContentView.swift
//  LayoutAndGeometry
//
//  Created by Pascal Sauer on 11.03.24.
//

import SwiftUI

struct ContentView: View {
    let colors: [Color] = [.red, .green, .blue, .orange, .pink, .purple, .yellow]

    var body: some View {
        GeometryReader { fullView in
            ScrollView(.vertical) {
                ForEach(0..<50) { index in
                    GeometryReader { proxy in
                        Text("Row #\(index)")
                            .font(.title)
                            .frame(maxWidth: .infinity)
                            .background(colors[index % 7])
                            .rotation3DEffect(
                                .degrees(proxy.frame(in: .global).minY - fullView.size.height / 2) / 5,
                                axis: (x: 0, y: 1, z: 0)
                            )
                            .opacity(Double((proxy.frame(in: .global).maxY - 200) / 100) + 1.1)
                            .scaleEffect(x: calcScaling(proxy, fullView))
                    }
                    .frame(height: 40)
                }
            }
        }
        .ignoresSafeArea()
    }
    
    func calcScaling(_ proxy: GeometryProxy, _ fullView: GeometryProxy) -> Double {
        let fullHeight = fullView.frame(in: .global).height
        let midY = proxy.frame(in: .global).midY
        let result = abs(midY / fullHeight)
        return result < 0.5 ? 0.5 : Double(result)
    }
}

#Preview {
    ContentView()
}
