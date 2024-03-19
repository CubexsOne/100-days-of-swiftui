//
//  ResultList.swift
//  RollDice
//
//  Created by Pascal Sauer on 19.03.24.
//

import SwiftUI
import SwiftData

struct ResultList: View {
    @Environment(\.modelContext) var modelContext
    @Query private var rollsResults: [RollsResult]

    var body: some View {
        ForEach(rollsResults) { result in
            HStack {
                Text(result.formattedRolls)
                Spacer()
                Text("=")
                Text("\(result.result)")
                    .frame(width: 35, alignment: .trailing)
            }
        }
        .onDelete(perform: deleteResult)
    }
    
    func deleteResult(indexSet: IndexSet) {
        for index in indexSet {
            let modelToDelete = rollsResults[index]
            modelContext.delete(modelToDelete)
        }
    }
}

#Preview {
    ResultList()
        .modelContainer(for: RollsResult.self)
}
