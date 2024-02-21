//
//  BuddyDetailView.swift
//  ConBuddy
//
//  Created by Pascal Sauer on 20.02.24.
//

import MapKit
import SwiftUI

struct BuddyDetailView: View {
    let buddy: Buddy
    var body: some View {
        buddy.potrait
            .resizable()
            .scaledToFit()
        Form {
            Section("Personal Data") {
                Text("First name")
                Text("Last name")
            }
            
            Section("Creation Location") {
                if let longitude = buddy.longitude {
                    if let latitude = buddy.latitude {
                        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                        let startPosition = MapCameraPosition.region(
                            MKCoordinateRegion(
                                center: coordinate,
                                span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1))
                        )
                        Map(initialPosition: startPosition) {
                            Marker("Met here", coordinate: coordinate)
                        }
                        .mapStyle(.standard)
                        .frame(maxWidth: .infinity, minHeight: 200)
                    }
                } else {
                    Text("No location found")
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .scrollBounceBehavior(.basedOnSize)
    }
}
