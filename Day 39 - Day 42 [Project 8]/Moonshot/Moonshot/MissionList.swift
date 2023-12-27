//
//  MissionList.swift
//  Moonshot
//
//  Created by Pascal Sauer on 25.12.23.
//

import SwiftUI

struct MissionList: View {
    let astronauts: [String: Astronaut]
    let missions: [Mission]

    var body: some View {
        List {
            ForEach(missions) { mission in
                NavigationLink {
                    MissionView(mission: mission, astronauts: astronauts)
                } label: {
                    VStack {
                        Image(mission.image)
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
                }
            }
        }
        .scrollContentBackground(.hidden)
    }
}
