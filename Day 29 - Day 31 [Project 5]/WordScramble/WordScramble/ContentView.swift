//
//  ContentView.swift
//  WordScramble
//
//  Created by Pascal Sauer on 11.12.23.
//

import SwiftUI

struct ContentView: View {
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""

    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
    @State private var score = 0

    var body: some View {
        NavigationStack {
            List {
                
                Text("Your Score: \(score)")
                    .frame(maxWidth: .infinity)
                    .multilineTextAlignment(.center)
                    .listRowBackground(Color.clear)
                Section {
                    TextField("Enter your word", text: $newWord)
                        .textInputAutocapitalization(.never)
                }
                
                Section(usedWords.count < 1 ? "" : "Your Words") {
                    ForEach(usedWords, id: \.self) { word in
                        HStack {
                            Image(systemName: "\(word.count).circle")
                            Text(word)
                        }
                    }
                }
            }
            .navigationTitle(rootWord)
            .onSubmit(addNewWord)
            .onAppear(perform: startGame)
            .alert(errorTitle, isPresented: $showingError) { } message: {
                Text(errorMessage)
            }
            .toolbar {
                Button("New Word") { startGame() }
            }
        }
    }
    
    func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        guard answer.count > 0 else { return }
        
        guard !isRoot(word: answer) else {
            wordError(title: "Same like start word", message: "You can't use the same word, like the start word")
            return
        }
        
        guard !isTooShort(word: answer) else {
            wordError(title: "Answer is too short", message: "Your answer must be at least 3 characters long")
            return
        }
        
        guard isOriginal(word: answer) else {
            wordError(title: "Word used already", message: "Be more original!")
            return
        }
        
        guard isPossible(word: answer) else {
            wordError(title: "Word now possible", message: "You can't spell that word from '\(rootWord)'")
            return
        }
        
        guard isReal(word: answer) else {
            wordError(title: "Word not recognized", message: "You can't just make them up, you know!'")
            return
        }
        
        withAnimation {
            score += calcScoreBy(answer: answer)
            usedWords.insert(answer, at: 0)
            newWord = ""
        }
    }
    
    func startGame() {
        if let startWordsUrl = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsUrl) {
                let allWords = startWords.components(separatedBy: "\n")
                rootWord = allWords.randomElement() ?? "silkworm"
                newWord = ""
                usedWords.removeAll()
                return
            }
        }
        
        fatalError("Could not load start.txt from bundle.")
    }
    
    func isRoot(word: String) -> Bool {
        word == rootWord
    }
    
    func isTooShort(word: String) -> Bool {
        word.count < 3
    }
    
    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }
    
    func isPossible(word: String) -> Bool {
        var tempWord = rootWord
        
        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }
        
        return true
    }
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return misspelledRange.location == NSNotFound
    }
    
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
        
        newWord = ""
    }
    
    func calcScoreBy(answer: String) -> Int {
        answer.count + usedWords.count
    }
}

#Preview {
    ContentView()
}
