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
        "none"
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
                .resizable()
                .scaledToFit()
        case "email":
            return Image("email")
                .resizable()
                .scaledToFit()
        case "facebook":
            return Image("facebook")
                .resizable()
                .scaledToFit()
        case "twitter":
            return Image("twitter")
                .resizable()
                .scaledToFit()
        default:
            return Image(systemName: "xmark.circle")
                .resizable()
                .scaledToFit()
        }
    }
}
