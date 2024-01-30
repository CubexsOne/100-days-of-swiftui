//
//  UserIcon.swift
//  FriendFace
//
//  Created by Pascal Sauer on 30.01.24.
//

import SwiftUI

struct UserIcon: View {
    var name: String
    var size: Double = 48.0
    var fontSize: Double = 16

    var body: some View {
        Text(createFirstChars(from: name))
            .font(.system(size: fontSize))
            .fontWeight(.bold)
            .frame(width: size, height: size)
            .background(LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 0.75, green: 0.75, blue: 0.75),
                    Color(red: 0.55, green: 0.55, blue: 0.55)
                ]),
                startPoint: .top,
                endPoint: .bottom))
            .foregroundColor(.white)
            .clipShape(.capsule)
    }
    
    func createFirstChars(from name: String) -> String {
        var firstChars = ""
        let names = name.split(separator: " ")
        
        for name in names {
            if let firstChar = name.first {
                firstChars += String(firstChar).uppercased()
            }
        }
        
        return firstChars
    }
}

#Preview {
    UserIcon(name: "Cubus Maximus")
}
