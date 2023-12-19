//
//  AddView.swift
//  iExpense
//
//  Created by Pascal Sauer on 19.12.23.
//

import SwiftUI

struct AddView: View {
    @Environment(\.dismiss) var dismiss

    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = 0.0
    
    @State private var showingAlert = false
    
    var expenses: Expenses
    
    let types = ["Business", "Personal"]
    

    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $name)
                
                Picker("Type", selection: $type) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }
                
                TextField("Amount", value: $amount, format: .currency(code: "USD"))
                    .keyboardType(.decimalPad)
            }
            .navigationTitle("Add new expense")
            .toolbar {
                Button("Save") {
                    if name.isEmpty {
                        showingAlert = true
                        return
                    }
                    let item = ExpenseItem(name: name, type: type, amount: amount)
                    expenses.items.append(item)
                    dismiss()
                }
            }
            .alert("Fehler beim speichern", isPresented: $showingAlert) {
                Button("Ok") { }
            } message: {
                Text("Der Name wurde nicht gesetzt!")
            }
        }
    }
}

#Preview {
    AddView(expenses: Expenses())
}
