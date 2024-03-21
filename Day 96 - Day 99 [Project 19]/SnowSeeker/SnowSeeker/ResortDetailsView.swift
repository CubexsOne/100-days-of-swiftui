//
//  ResortDetailsView.swift
//  SnowSeeker
//
//  Created by Pascal Sauer on 21.03.24.
//

import SwiftUI

struct ResortDetailsView: View {
    let resort: Resort
    
    var size: String {
        ["Small", "Average", "Large"][resort.size - 1]
    }
    
    var price: String {
        String(repeating: "$", count: resort.price)
    }

    var body: some View {
        Group {
            VStack {
                Text("Size")
                    .font(.caption.bold())
                
                Text(size)
                    .font(.title3)
            }
            
            VStack {
                Text("Price")
                    .font(.caption.bold())
                
                Text(price)
                    .font(.title3)
            }
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    ResortDetailsView(resort: .example)
}
