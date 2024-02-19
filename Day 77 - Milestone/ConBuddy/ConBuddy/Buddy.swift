//
//  Buddy.swift
//  ConBuddy
//
//  Created by Pascal Sauer on 19.02.24.
//

import Foundation
import PhotosUI
import SwiftData
import SwiftUI

@Model
class Buddy {
    var firstName: String
    var lastName: String
    @Attribute(.externalStorage) var image: Data
    
    var potrait: Image {
        if let uiImage = UIImage(data: image) {
            return Image(uiImage: uiImage)
        }
        return Image(systemName: "person.slash.fill")
    }
    
    init(firstName: String, lastName: String, image: Data) {
        self.firstName = firstName
        self.lastName = lastName
        self.image = image
    }
}
