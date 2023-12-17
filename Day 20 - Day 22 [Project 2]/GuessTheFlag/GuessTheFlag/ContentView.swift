//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Pascal Sauer on 02.12.23.
//

import SwiftUI

struct FlagImage: View {
    let image: String

    var body: some View {
        Image(image)
            .clipShape(.capsule)
            .shadow(radius: 5)
    }
}

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var highScore = 0
    
    @State private var showingEndcard = false
    @State private var rounds = 0
    let maxRounds = 8
    
    @State private var flagRotation = [0.0, 0.0, 0.0]
    @State private var answered = false
    @State private var tappedAnswer = -1
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()

            VStack {
                Spacer()

                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                            answered = true
                            tappedAnswer = number
                        } label: {
                            FlagImage(image: countries[number])
                        }.rotation3DEffect(
                            .degrees(flagRotation[number]),
                            axis: /*@START_MENU_TOKEN@*/(x: 0.0, y: 1.0, z: 0.0)/*@END_MENU_TOKEN@*/
                        )
                        .opacity(answered && number != tappedAnswer ? 0.25 : 1)
                        .scaleEffect(answered && number != tappedAnswer ? 0.25 : 1)
                        .animation(.linear, value: answered)
                        
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score \(score)")
                    .foregroundStyle(.white)
                    .font(.title.bold())

                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(score)")
        }
        .alert("Game Over: \(score)", isPresented: $showingEndcard) {
            Button("Restart") {
                rounds = 0
                score = 0
                askQuestion()
            }
        } message: {
            Text("The Highscore is \(highScore)")
        }
    }
    
    func flagTapped(_ number: Int) {
        withAnimation {
            flagRotation[number] += 360
        }

        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 10
        } else {
            scoreTitle = "Wrong! Thats the flag of \(countries[number])"
            score -= 10
        }
        
        showingScore = true
    }
    
    func askQuestion() {
        if rounds == maxRounds {
            if score > highScore {
                highScore = score
            }
            showingEndcard = true
            return
        }
        rounds += 1
        answered = false
        tappedAnswer = -1
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

#Preview {
    ContentView()
}
