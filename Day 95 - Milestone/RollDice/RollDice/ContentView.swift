//
//  ContentView.swift
//  RollDice
//
//  Created by Pascal Sauer on 18.03.24.
//

import CoreHaptics
import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query private var rollsResults: [RollsResult]
    
    @State private var engine: CHHapticEngine?
    
    @State private var diceAmount = 0
    @State private var sides = 2
    @State private var diceDisplayValue = 0
    @State private var diceResult = 0
    @State private var rolls = [Int]()
    @State private var timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()
    @State private var rollsDone = 0
    let maxRollDuration = 10
    
    @State private var showDeleteAlert = false

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Text(String(diceDisplayValue))
                        .font(.system(size: 128))
                        .frame(
                            maxWidth: .infinity,
                            alignment: .center
                        )
                    Text("Tap to roll")
                        .font(.caption)
                        .frame(
                            maxWidth: .infinity,
                            alignment: .center
                        )
                }
                .listRowSeparator(.hidden)
                .onTapGesture {
                    resetRolls()
                    timer = Timer.publish(every: 0.25, on: .main, in: .common).autoconnect()
                }
                SettingsView(diceAmount: $diceAmount, sides: $sides)
                    .disabled(rollsDone != 0)

                if rollsResults.isEmpty == false {
                    Section("Results") {
                        ResultList()
                    }
                    Button("Delete all results", role: .destructive) {
                        showDeleteAlert = true
                    }
                }
            }
            .scrollBounceBehavior(.basedOnSize)
            .navigationTitle("Roll Dice")
            .onAppear {
                timer.upstream.connect().cancel()
                prepareHaptics()
            }
            .onReceive(timer) { time in
                if rollsDone < maxRollDuration {
                    rollTheDice(finalRoll: false)
                    return
                }
                
                timer.upstream.connect().cancel()
                rollTheDice(finalRoll: true)
                rolls.forEach { value in
                    diceResult += value
                }
                diceDisplayValue = diceResult
                let newRollResult = RollsResult(diceAmount: diceAmount, sides: sides, rolls: rolls, result: diceResult)
                modelContext.insert(newRollResult)
                rollsDone = 0
            }
            .alert("Delete all Results?", isPresented: $showDeleteAlert) {
                Button("Cancel", role: .cancel) {}
                Button("Delete", role: .destructive) {
                    for model in rollsResults {
                        modelContext.delete(model)
                    }
                }
            } message: {
                Text("Do you really want to delete all results?")
            }
        }
    }
    
    func rollTheDice(finalRoll: Bool) {
        rollHaptic()
        rollsDone += 1
        let fixedDiceAmount = diceAmount + 1
        let fixedSides = sides + 4

        for _ in 1...fixedDiceAmount {
            let newRoll = Int.random(in: 1...fixedSides)
            withAnimation {
                diceDisplayValue = newRoll
            }
            if finalRoll {
                rolls.append(newRoll)
            }
        }
    }
    
    func resetRolls() {
        rolls = []
        diceDisplayValue = 0
        diceResult = 0
    }
    
    func prepareHaptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        
        do {
            engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            print("There was an error creating the engine: \(error.localizedDescription)")
        }
    }
    
    func rollHaptic() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        
        var events = [CHHapticEvent]()
        
        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(1))
        let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(0.8))
        let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 0.5)
        events.append(event)
        
        do {
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let placer = try engine?.makePlayer(with: pattern)
            try placer?.start(atTime: 0)
        } catch {
            print("Failed to play pattern: \(error.localizedDescription)")
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: RollsResult.self)
}
