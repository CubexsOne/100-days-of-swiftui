//
//  ContentView.swift
//  Flashzilla
//
//  Created by Pascal Sauer on 03.03.24.
//

import SwiftUI

extension View {
    func stacked(at position: Int, in total: Int) -> some View {
        let offset = Double(total - position)
        return self.offset(y: offset * 10)
    }
}

struct ContentView: View {
    @State private var cards = Array<Card>(repeating: .example, count: 10)

    var body: some View {
        ZStack {
            Image(.background)
                .resizable()
                .ignoresSafeArea()
            VStack {
                ZStack {
                    ForEach(0..<cards.count, id: \.self) { index in
                        CardView(card: .example)
                            .stacked(at: index, in: cards.count)
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}