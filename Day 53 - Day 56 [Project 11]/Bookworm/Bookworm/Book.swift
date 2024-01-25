//
//  Book.swift
//  Bookworm
//
//  Created by Pascal Sauer on 23.01.24.
//

import SwiftData
import Foundation

@Model
class Book {
    var title: String
    var author: String
    var genre: String
    var review: String
    var rating: Int
    var creationDate: Date
    
    var formattedCreationDate: String {
        creationDate.formatted(date: .abbreviated, time: .omitted)
    }
    
    init(title: String, author: String, genre: String, review: String, rating: Int, creationDate: Date) {
        self.title = title
        self.author = author
        self.genre = genre
        self.review = review
        self.rating = rating
        self.creationDate = creationDate
    }
}
