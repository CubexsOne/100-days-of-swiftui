//
//  AddBookView.swift
//  Bookworm
//
//  Created by Pascal Sauer on 23.01.24.
//

extension String {
    func isTrimmedEmpty() -> Bool {
        self.trimmingCharacters(in: .whitespaces).isEmpty
    }
}

import SwiftUI

struct AddBookView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre = "Fantasy"
    @State private var review = ""

    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
    
    var hasValidInput: Bool {
        if title.isTrimmedEmpty() || author.isTrimmedEmpty() || review.isTrimmedEmpty() {
            return false
        }
        return true
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Name of book", text: $title)
                    TextField("Author's name", text: $author)
                    
                    Picker("Genre", selection: $genre) {
                        ForEach(genres, id: \.self) {
                            Text($0)
                        }
                    }
                }
                
                Section("Write a review") {
                    TextEditor(text: $review)
                    RatingView(rating: $rating)
                }
                
                Section {
                    Button("Save") {
                        let newBook = Book(title: title, author: author, genre: genre, review: review, rating: rating, creationDate: .now)
                        
                        modelContext.insert(newBook)
                        dismiss()
                    }
                }
                .disabled(hasValidInput == false)
            }
            .navigationTitle("Add Book")
        }
    }
}

#Preview {
    AddBookView()
}
