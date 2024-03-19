//
//  SettingsView.swift
//  RollDice
//
//  Created by Pascal Sauer on 18.03.24.
//

import SwiftUI

struct SettingsView: View {
    @Binding var diceAmount: Int
    @Binding var sides: Int

    var body: some View {
        Section("Settings") {
            HStack {
                VStack {
                    Text("Dices")
                    Picker("Dices", selection: $diceAmount) {
                        ForEach(1..<21) { i in
                            Text(String(i))
                        }
                    }
                    .pickerStyle(.wheel)
                    .frame(height: 128)
                }
                
                VStack {
                    Text("Sides")
                    Picker("Sides", selection: $sides) {
                        ForEach(4..<101) { i in
                            Text(String(i))
                        }
                    }
                    .pickerStyle(.wheel)
                    .frame(height: 128)
                }
            }
        }
    }
}

#Preview {
    SettingsView(diceAmount: .constant(1), sides: .constant(4))
}
