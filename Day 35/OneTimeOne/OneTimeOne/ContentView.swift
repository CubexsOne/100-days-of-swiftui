//
//  ContentView.swift
//  OneTimeOne
//
//  Created by Pascal Sauer on 17.12.23.
//

import SwiftUI

enum AnswerStatus {
    case correct, wrong, waiting
}


struct ContentView: View {
    @State private var isGameActive = false
    
    @State private var selectLevel = 0
    var selectedLevel: Int {
        selectLevel + 1
    }
    @State private var round = 1
    @State private var maxRounds = 10
    let possibleRounds = [10, 20, 30]
    @State private var randomNumber = Int.random(in: 1...10)
    
    var correctAnswer: Int {
        selectedLevel * randomNumber
    }
    @State private var answerInput = ""
    @State private var answerStatus = AnswerStatus.waiting
    
    var body: some View {
        NavigationStack {
            List {
                if !isGameActive {
                    Section("Wähle eine Kategorie") {
                        Picker("Kategorie Wahl", selection: $selectLevel) {
                            ForEach(1..<11) {
                                Text("\($0)")
                            }
                        }
                        .labelsHidden()
                        .pickerStyle(.segmented)
                        VStack(alignment: .leading) {
                            Text("Wähle Runden:")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                            Picker("Kategorie Wahl", selection: $maxRounds) {
                                ForEach(possibleRounds, id: \.self) {
                                    Text("\($0)")
                                }
                            }
                            .pickerStyle(.segmented)
                        }
                        
                        HStack {
                            Button("Starten") {
                                isGameActive.toggle()
                            }
                            .padding(10)
                            .frame(width: 100)
                            .background(.green)
                            .foregroundColor(.white)
                            .clipShape(.capsule)
                            .multilineTextAlignment(.center)
                        }
                        .frame(maxWidth: .infinity)
                    }
                }
                
                if isGameActive {
                    HStack {
                        VStack {
                            Text("\(selectedLevel) x \(randomNumber) = ?")
                                .frame(width: 150, height: 60)
                                .background(getQuestionBackground())
                                .clipShape(.rect(cornerRadius: 16))
                                .opacity(answerStatus != AnswerStatus.waiting ? 0.75 : 1)
                                .offset(CGSize(width: 0, height: answerStatus != AnswerStatus.waiting ? -40 : 0))
                                .animation(.easeInOut(duration: 0.25), value: answerStatus)
                            
                            Text("\(round) / \(maxRounds)")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                    }
                    .listRowBackground(Color.clear)
                    .frame(maxWidth: .infinity, minHeight: 120)
                    Section("Was ist die Lösung?") {
                        HStack {
                            TextField("Lösung?", text: $answerInput)
                                .keyboardType(.decimalPad)
                            Button("Senden") {
                                giveAnswer()
                            }
                        }
                    }
                }
            }
            .onSubmit(giveAnswer)
            .navigationTitle(!isGameActive ? "One Time One" : "\(selectedLevel) x \(selectedLevel)")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    func giveAnswer() {
        round += 1
        let givenAnswer = Int(answerInput)
        if givenAnswer == correctAnswer {
            answerStatus = .correct
        } else {
            answerStatus = .wrong
        }

        answerInput = ""
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            answerStatus = .waiting
            if round <= maxRounds {
                nextQuestion()
            } else {
                isGameActive = false
                round = 1
            }
        }

        print("Answer is: \(answerStatus)")
    }
    
    func nextQuestion() {
        randomNumber = Int.random(in: 1...10)
    }
    
    func getQuestionBackground() -> Color {
        switch answerStatus {
        case .correct:
            return .green
        case .wrong:
            return .red
        case .waiting:
            return .white
        }
    }
}

#Preview {
    ContentView()
}
