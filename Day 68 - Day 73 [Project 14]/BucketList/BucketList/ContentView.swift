//
//  ContentView.swift
//  BucketList
//
//  Created by Pascal Sauer on 07.02.24.
//

import MapKit
import SwiftUI

struct ContentView: View {
    let startPosition = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 49.484680, longitude: 8.476720),
            span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1))
    )
    
    @State private var viewModel = ViewModel()

    var body: some View {
        if true {
//        if viewModel.isUnlocked {
            MapReader { proxy in
                Map(initialPosition: startPosition) {
                    ForEach(viewModel.locations) { location in
                        Annotation(location.name, coordinate: location.coordinate) {
                            Image(systemName: "star.circle")
                                .resizable()
                                .foregroundStyle(.red)
                                .frame(width: 44, height: 44)
                                .background(.white)
                                .clipShape(.circle)
                                .onLongPressGesture {
                                    viewModel.selectedPlace = location
                                }
                        }
                    }
                }
                .mapStyle(viewModel.isHybrid ? .hybrid : .standard)
                .onTapGesture { position in
                    if let coordinate = proxy.convert(position, from: .local) {
                        viewModel.addLocation(at: coordinate)
                    }
                }
                .sheet(item: $viewModel.selectedPlace) { place in
                    EditView(location: place, onSave: viewModel.update, onDelete: viewModel.delete)
                }
            }
            ScrollView {
                HStack() {
                    Spacer()
                    Menu("Settings") {
                        Toggle("Hybrid", isOn: $viewModel.isHybrid)
                    }
                }
                .padding(.horizontal)
                .frame(maxWidth: .infinity)
                
                Divider()
                
                ForEach(viewModel.locations) { location in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(location.name)
                                .font(.headline)
                            Text(location.description)
                                .italic()
                        }
                        Spacer()
                    }
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity)
                    .frame(height: 64)
                    .background(Color(red: 0.96, green: 0.96, blue: 0.96))
                    .clipShape(.rect(cornerRadius: 8))
                    .padding(.horizontal)
                    .onTapGesture {
                        viewModel.selectedPlace = location
                    }
                }
            }
            .scrollBounceBehavior(.basedOnSize)
        } else {
            Button("Unlock Places", action: viewModel.authenticate)
                .padding()
                .background(.blue)
                .foregroundStyle(.white)
                .clipShape(.capsule)
                .alert("Error", isPresented: $viewModel.showAlert) {
                    Button("Ok") { }
                } message: {
                    Text(viewModel.errorMessage)
                }
        }
    }
}

#Preview {
    ContentView()
}
