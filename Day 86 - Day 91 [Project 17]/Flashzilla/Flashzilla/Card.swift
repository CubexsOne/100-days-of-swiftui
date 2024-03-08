//
//  Card.swift
//  Flashzilla
//
//  Created by Pascal Sauer on 05.03.24.
//

import Foundation

struct Card: Identifiable, Codable {
    var id: UUID
    var prompt: String
    var answer: String
    
    static let example = Card(id: UUID(), prompt: "Who played the 13th Doctor in Doctor Who?", answer: "Jodie Whittaker")
}
