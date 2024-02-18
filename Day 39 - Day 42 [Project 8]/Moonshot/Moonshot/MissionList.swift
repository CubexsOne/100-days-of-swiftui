//
//  MissionList.swift
//  Moonshot
//
//  Created by Pascal Sauer on 25.12.23.
//

import SwiftUI

struct MissionList: View {
    let missions: [Mission]

    var body: some View {
        List {
            ForEach(missions) { mission in
                NavigationLink(value: mission) {
                    VStack {
                        Image(decorative: mission.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                            .clipShape(.circle)
                            .overlay {
                                Circle()
                                    .stroke(.lightBackground)
                            }
                        Text(mission.displayName)
                            .font(.caption)
                            .foregroundStyle(.white.opacity(0.5))
                    }
                    .accessibilityElement()
                    .accessibilityLabel("\(mission.displayName) launched on \(mission.formattedLaunchDate)")
                }
            }
        }
        .scrollContentBackground(.hidden)
    }
}
