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

    
    var body: some View {
        List {
            Section {
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
                    .accessibilityElement()
                    .accessibilityLabel("\(item.name) for \(item.amount) €")
                    .accessibilityHint(item.type)
                }
                .onDelete(perform: deleteItem)
            }            
        }
    }
    
    init(filterTypes: [String], sortOrder: [SortDescriptor<ExpenseItem>]) {
        _items = Query(filter: #Predicate<ExpenseItem> { item in
            filterTypes.contains(item.type)
        }, sort: sortOrder)
    }
    
    func deleteItem(at offsets: IndexSet) {
        for offset in offsets {
            let item = items[offset]
            modelContext.delete(item)
        }
    }
}

#Preview {
    ListFilteredByType(filterTypes: ["Personal"], sortOrder: [SortDescriptor(\.name)])
    .modelContainer(for: ExpenseItem.self)
}
