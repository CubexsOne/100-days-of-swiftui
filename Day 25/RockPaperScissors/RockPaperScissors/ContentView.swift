//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Pascal Sauer on 07.12.23.
//

import SwiftUI

enum Move {
    case rock, paper, scissors
}
let moveIconMap: [Move: String] = [.rock: "🪨", .paper: "📃", .scissors: "✂️"]

struct ContentView: View {
    @State private var moves: [Move] = [.rock, .paper, .scissors].shuffled()
    @State private var roundResult = Bool.random()
    
    @State private var showResult = false
    @State private var score = 0
    @State private var rounds = 1
    let maxRounds = 10
    
    var body: some View {
        VStack {
            Spacer()
            Text("Rock, Paper, Scissors")
                .foregroundColor(.white)
                .font(.largeTitle)
            Spacer()
            VStack {
                VStack {
                    Text("You should\(roundResult ? "" : " not") beat my")
                        .font(.title)
                    Text("\(moveIconMap[moves[0]] ?? "")")
                        .font(.system(size: 96))
                    
                    Text("What do you chose?")
                        .font(.headline)
                    HStack {
                        ForEach(1..<3) { number in
                            Button {
                                answerQuestion(number)
                                askQuestion()
                            } label: {
                                Text(moveIconMap[moves[number]] ?? "")
                                    .font(.system(size: 64))
                            }
                            .padding(.horizontal, 20)
                        }
                        .padding(.top, 10)
                    }
                }
                .frame(width: 320)
                .padding()
                .background(.ultraThinMaterial)
                .clipShape(.rect(cornerRadius: 16))
            }
            Text("Score: \(score)")
                .font(.largeTitle)
                .foregroundStyle(.white)
                .padding()
            Spacer()
            Spacer()
        }
        .alert("Game Over", isPresented: $showResult) {
            Button("Restart") {
                reset()
                askQuestion()
            }
        } message: {
            Text("You scored \(score)")
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(red: 0.35, green: 0, blue: 0.2).gradient)
    }
    
    func answerQuestion(_ answer: Int) {
        var isWinning = false
        switch moves[0] {
        case .rock:
            if moves[answer] == .paper {
                isWinning = true
            }
        case .paper:
            if moves[answer] == .scissors {
                isWinning = true
            }
        case .scissors:
            if moves[answer] == .rock {
                isWinning = true
            }
        }
        
        if isWinning && roundResult {
            score += 1
        } else if !isWinning && !roundResult {
            score += 1
        } else {
            score -= 1
        }
    }
    
    func askQuestion() {
        if rounds == maxRounds {
            showResult.toggle()
            return
        }
        rounds += 1;
        moves.shuffle()
        roundResult = Bool.random()
    }
    
    func reset() {
        rounds = 0
        score = 0
        moves.shuffle()
        roundResult = Bool.random()
    }
}

#Preview {
    ContentView()
}
