//
//  BuddyDetailEditView.swift
//  ConBuddy
//
//  Created by Pascal Sauer on 21.02.24.
//

import MapKit
import SwiftUI

struct BuddyDetailEditView: View {
    @State var buddy: Buddy

    var body: some View {
        buddy.potrait
            .resizable()
            .scaledToFit()
        Form {
            Section("Personal Data") {
                TextField("Firstname", text: $buddy.firstName)
                TextField("Lastname", text: $buddy.lastName)
            }
            
            Section("Location") {
                if let longitude = buddy.longitude {
                    if let latitude = buddy.latitude {
                        TextField("Location", text: $buddy.locationName)
                        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                        let startPosition = MapCameraPosition.region(
                            MKCoordinateRegion(
                                center: coordinate,
                                span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1))
                        )
                        MapReader { proxy in
                            Map(initialPosition: startPosition) {
                                Marker(buddy.locationName, coordinate: coordinate)
                            }
                            .mapStyle(.standard)
                            .onTapGesture { position in
                                if let coordinate = proxy.convert(position, from: .local) {
                                    buddy.latitude = coordinate.latitude
                                    buddy.longitude = coordinate.longitude
                                }
                            }
                        }
                        .frame(maxWidth: .infinity, minHeight: 200)
                    }
                } else {
                    Text("No location found")
                }
            }
        }
        .scrollBounceBehavior(.basedOnSize)
    }
}
