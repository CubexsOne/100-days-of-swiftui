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
    
    let locationFetcher = LocationFetcher()
    
    
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
                .onChange(of: selectedItem, loadImage)
                
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
                        let newBuddy = Buddy(firstName: firstName, lastName: lastName, image: imageData)
                        
                        if let location = locationFetcher.lastKnownLocation {
                            newBuddy.latitude = location.latitude
                            newBuddy.longitude = location.longitude
                        }
                        modelContext.insert(newBuddy)
                        dismiss()
                    }.disabled(validBuddy == false)
                }
                
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
            }
            .onAppear {
                locationFetcher.start()
            }
        }
    }
    
    func loadImage() {
        Task {
            guard let imageData = try await selectedItem?.loadTransferable(type: Data.self) else { return }
            self.imageData = imageData
            guard let uiImage = UIImage(data: imageData) else { return }
            self.selectedImage = Image(uiImage: uiImage)
        }
    }
}

#Preview {
    BuddyAddView()
        .modelContainer(for: Buddy.self)
}
