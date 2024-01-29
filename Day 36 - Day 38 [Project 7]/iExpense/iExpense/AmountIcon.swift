//
//  AmountIcon.swift
//  iExpense
//
//  Created by Pascal Sauer on 29.01.24.
//

import SwiftUI

struct AmountIcon: View {
    let amount: Double

    var body: some View {
        switch amount {
        case 0...10:
            Spacer().frame(width: 30)
        case 11...99:
            Image(systemName: "exclamationmark.triangle.fill")
                .foregroundColor(Color(red: 1, green: 0.64, blue: 0))
        default:
            Image(systemName: "exclamationmark.triangle.fill")
                .foregroundColor(.red)
        }
    }
}

#Preview {
    AmountIcon(amount: 0)
}
