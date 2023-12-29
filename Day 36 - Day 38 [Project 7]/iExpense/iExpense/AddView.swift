//
//  AddView.swift
//  iExpense
//
//  Created by Pascal Sauer on 19.12.23.
//

import SwiftUI


let PLACE_HOLDER = "Insert Item Name"
struct AddView: View {
    @Environment(\.dismiss) var dismiss

    @State private var name = PLACE_HOLDER
    @State private var type = "Personal"
    @State private var amount = 0.0
    
    @State private var showingAlert = false
    
    var expenses: Expenses
    
    var body: some View {
        NavigationStack {
            Form {
                Picker("Type", selection: $type) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }
                
                TextField("Amount", value: $amount, format: .currency(code: localCurrency))
                    .keyboardType(.decimalPad)
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle($name)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        if name == PLACE_HOLDER {
                            showingAlert = true
                            return
                        }
                        let item = ExpenseItem(name: name, type: type, amount: amount)
                        expenses.items.append(item)
                        dismiss()
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
            .alert("Fehler beim speichern", isPresented: $showingAlert) {
                Button("Ok") { }
            } message: {
                Text("Der Name wurde nicht gesetzt!")
            }
            .navigationBarBackButtonHidden()
        }
    }
}

#Preview {
    AddView(expenses: Expenses())
}
