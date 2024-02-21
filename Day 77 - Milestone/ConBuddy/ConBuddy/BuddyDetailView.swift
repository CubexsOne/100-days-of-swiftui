//
//  BuddyDetailView.swift
//  ConBuddy
//
//  Created by Pascal Sauer on 20.02.24.
//

import MapKit
import SwiftData
import SwiftUI

struct BuddyDetailView: View {
    let buddy: Buddy
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    @State private var showDeleteAlert = false
    @State private var isEditing = false
    
    var body: some View {
        VStack {
            if isEditing {
                BuddyDetailEditView(buddy: buddy)
            } else {
                BuddyDetailShowView(buddy: buddy)                
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .alert("Delete buddy?", isPresented: $showDeleteAlert) {
            Button("Cancel", role: .cancel) { }
            Button("Delete", role: .destructive) {
                modelContext.delete(buddy)
                dismiss()
            }
        }
        .toolbar {
            ToolbarItem(placement: .destructiveAction) {
                Button("Delete buddy", systemImage: "trash") {
                    showDeleteAlert = true
                }
            }
            
            ToolbarItem(placement: .primaryAction) {
                Button("\( isEditing ? "Done" : "Edit")") {
                    isEditing.toggle()
                }
            }
        }
    }
}
