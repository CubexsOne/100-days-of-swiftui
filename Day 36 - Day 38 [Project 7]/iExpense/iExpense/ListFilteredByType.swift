//
//  ListFilteredByType.swift
//  iExpense
//
//  Created by Pascal Sauer on 29.01.24.
//

import SwiftData
import SwiftUI

struct ListFilteredByType: View {
    @Environment(\.modelContext) var modelContext
    @Query var items: [ExpenseItem]
    let type: String

    
    var body: some View {
        if items.count > 0 {
            Section(type) {
                ForEach(items) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                            
                            Text(item.type)
                        }
                        
                        Spacer()
                        
                        HStack {
                            Text(item.amount, format: .currency(code: localCurrency))
                            AmountIcon(amount: item.amount)
                        }
                        
                    }
                }
                .onDelete(perform: deleteItem)
            }
        }
    }
    
    init(type: String) {
        _items = Query(filter: #Predicate<ExpenseItem> { item in
            item.type.localizedStandardContains(type)
        })
        self.type = type
    }
    
    func deleteItem(at offsets: IndexSet) {
        for offset in offsets {
            let item = items[offset]
            modelContext.delete(item)
        }
    }
}

#Preview {
    ListFilteredByType(type: "Personal")
    .modelContainer(for: ExpenseItem.self)
}
