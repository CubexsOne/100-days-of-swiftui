//
//  EditView.swift
//  BucketList
//
//  Created by Pascal Sauer on 12.02.24.
//

import SwiftUI

struct EditView: View {
    @Environment(\.dismiss) var dismiss
    var onSave: (Location) -> Void
    var onDelete: (Location) -> Void
    
    @State private var viewModel: ViewModel
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Place name", text: $viewModel.name)
                    TextField("Description", text: $viewModel.description)
                }
                
                Section("Nearby...") {
                    switch viewModel.loadingState {
                    case .loading:
                        Text("Loading...")
                        
                    case .loaded:
                        ForEach(viewModel.pages, id: \.pageid) { page in
                            Text(page.title)
                                .font(.headline)
                            
                            + Text(": ") +
                            
                            Text(page.description)
                                .italic()
                        }
                        
                    case .failed:
                        Text("Please try again later.")
                    }
                    
                }
            }
            .navigationTitle("Place details")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button("Save") {
                        var newLocation = viewModel.location
                        newLocation.id = UUID()
                        newLocation.name = viewModel.name
                        newLocation.description = viewModel.description
                        
                        onSave(newLocation)
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .destructiveAction) {
                    Button {
                        viewModel.showConfirmation = true
                    } label: {
                        Image(systemName: "trash")
                            .foregroundStyle(.red)
                    }
                }
            }
            .task {
                await viewModel.fetchNearbyPlaces()
            }
            .alert("Delete this Location?", isPresented: $viewModel.showConfirmation) {
                Button("Delete", role: .destructive) {
                    onDelete(viewModel.location)
                    dismiss()
                }
                Button("Cancel", role: .cancel) { }
            }
        }
    }
    
    init(location: Location, onSave: @escaping (Location) -> Void, onDelete: @escaping (Location) -> Void) {
        self.onSave = onSave
        self.onDelete = onDelete
        _viewModel = State(initialValue: ViewModel(location: location))
    }
}

#Preview {
    EditView(location: Location.example) { _ in } onDelete: { _ in }
}
