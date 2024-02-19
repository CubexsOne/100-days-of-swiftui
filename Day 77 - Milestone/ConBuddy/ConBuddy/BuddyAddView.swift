//
//  BuddyAddView.swift
//  ConBuddy
//
//  Created by Pascal Sauer on 19.02.24.
//

import PhotosUI
import SwiftUI

struct BuddyAddView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext

    @State private var selectedItem: PhotosPickerItem?
    @State private var imageData: Data?
    @State private var selectedImage: Image?
    @State private var firstName: String = "FirstName"
    @State private var lastName = "LastName"
    
    var validBuddy: Bool {
        firstName.isEmpty == false && lastName.isEmpty == false && imageData != nil
    }

    var body: some View {
        NavigationStack {
            Form {
                PhotosPicker(selection: $selectedItem) {
                    if let selectedImage {
                        selectedImage
                            .resizable()
                            .scaledToFit()
                    } else {
                        ContentUnavailableView(
                            "No image selected",
                            systemImage: "photo.badge.plus",
                            description: Text("Tap to import a photo")
                        )
                    }
                }
                .buttonStyle(.plain)
                
                Section("Personal Data") {
                    TextField("First name", text: $firstName)
                    TextField("Last name", text: $lastName)
                }
            }
            .navigationTitle("Add new buddy")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button("Save") {
                        guard let imageData else { return }
                        let newBuddy = Buddy(id: UUID(), firstName: firstName, lastName: lastName, image: imageData)
                        modelContext.insert(newBuddy)
                    }.disabled(validBuddy == false)
                }
                
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
            }
        }
    }
}

#Preview {
    BuddyAddView()
}
