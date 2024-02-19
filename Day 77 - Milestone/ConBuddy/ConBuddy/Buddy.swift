//
//  Buddy.swift
//  ConBuddy
//
//  Created by Pascal Sauer on 19.02.24.
//

import Foundation
import SwiftData

@Model
class Buddy: Identifiable {
    var id: UUID
    var firstName: String
    var lastName: String
    @Attribute(.externalStorage) var image: Data
    
    init(id: UUID, firstName: String, lastName: String, image: Data) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.image = image
    }
}
