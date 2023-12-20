//
//  ContentView.swift
//  iExpense
//
//  Created by Pascal Sauer on 18.12.23.
//

import SwiftUI

let localCurrency = Locale.current.currency?.identifier ?? "USD"
let types = ["Business", "Personal"]

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    
    let name: String
    let type: String
    let amount: Double
}

@Observable
class Expenses {
    var items = [ExpenseItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                items = decodedItems
                return
            }
        }
        
        items = []
    }
}

struct AmountIcon: View {
    let amount: Double

    var body: some View {
        switch amount {
        case 0...10:
            Spacer().frame(width: 30)
        case 11...100:
            Image(systemName: "exclamationmark.triangle.fill")
                .foregroundColor(Color(red: 1, green: 0.64, blue: 0))
        default:
            Image(systemName: "exclamationmark.triangle.fill")
                .foregroundColor(.red)
        }
    }
}

struct ListFilteredByType: View {
    let type: String
    var items: [ExpenseItem]
    let removeItem: (Int) -> Void
    
    var filteredItems: [ExpenseItem] {
        items.filter({ item in
            item.type == type
        })
    }
    
    var body: some View {
        if filteredItems.count > 0 {
            Section(type) {
                ForEach(filteredItems) { item in
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
    
    func deleteItem(at offsets: IndexSet) {
        for index in offsets {
            if let deleteIndex = items.firstIndex(where: { item in
                item.id == filteredItems[index].id
            }) {
                removeItem(deleteIndex)
            }
        }
    }
}

struct ContentView: View {
    @State private var expenses = Expenses()
    
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(types, id:\.self) {
                    ListFilteredByType(type: $0, items: expenses.items, removeItem: removeItem)
                }
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button("Add Expense", systemImage: "plus") {
                    showingAddExpense = true
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: expenses)
            }
        }
    }
    
    func removeItem(at index:  Int) {
        expenses.items.remove(at: index)
    }
}

#Preview {
    ContentView()
}
