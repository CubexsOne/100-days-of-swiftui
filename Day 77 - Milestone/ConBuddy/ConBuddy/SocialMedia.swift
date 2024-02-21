//
//  SocialMedia.swift
//  ConBuddy
//
//  Created by Pascal Sauer on 21.02.24.
//

import Foundation
import SwiftData
import SwiftUI

@Model
class SocialMedia {
    static let categories = [
        "discord",
        "email",
        "facebook",
        "twitter",
    ]
    
    var type: String
    var value: String
    var Buddy: Buddy?
    
    var icon: some View {
        SocialMedia.getImageBy(category: type)
    }
    
    init(type: String, value: String, Buddy: Buddy? = nil) {
        self.type = type
        self.value = value
        self.Buddy = Buddy
    }
    
    static func getImageBy(category: String) -> some View {
        switch category {
        case "discord":
            return Image("discord")
                .foregroundStyle(Color(red: 88, green: 101, blue: 242))
        case "email":
            return Image("email")
                .foregroundStyle(.black)
        case "facebook":
            return Image("facebook")
                .foregroundStyle(Color(red: 66, green: 103, blue: 178))
        case "twitter":
            return Image("twitter")
                .foregroundStyle(Color(red: 29, green: 161, blue: 242))
        default:
            return Image(systemName: "xmark.circle")
                .foregroundStyle(.black)
        }
    }
}
