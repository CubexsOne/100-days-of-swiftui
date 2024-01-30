//
//  DetailViewTextBox.swift
//  FriendFace
//
//  Created by Pascal Sauer on 30.01.24.
//

import SwiftUI

struct DetailViewTextBox: View {
    var title: String
    var content: String
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(title)
                    .padding(.vertical, 8)
                Text(content)
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
        }
        .frame(maxWidth: .infinity)
        .background(.gray)
        .clipShape(.rect(cornerRadius: 8))
        .padding(4)
        .padding(.bottom, 16)
    }
}

#Preview {
    DetailViewTextBox(title: "Textbox", content: "Content")
}
