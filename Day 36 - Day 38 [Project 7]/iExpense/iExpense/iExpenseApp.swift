//
//  iExpenseApp.swift
//  iExpense
//
//  Created by Pascal Sauer on 18.12.23.
//

import SwiftData
import SwiftUI

@main
struct iExpenseApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: ExpenseItem.self)
    }
}
