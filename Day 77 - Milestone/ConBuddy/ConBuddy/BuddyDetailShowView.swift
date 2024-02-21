//
//  BuddyDetailShowView.swift
//  ConBuddy
//
//  Created by Pascal Sauer on 21.02.24.
//

import MapKit
import SwiftUI

struct BuddyDetailShowView: View {
    let buddy: Buddy

    var body: some View {
        ZStack(alignment: .bottom) {
            buddy.potrait
                .resizable()
                .scaledToFit()
            Text("\(buddy.firstName) \(buddy.lastName)")
                .font(.title)
                .foregroundColor(.white)
                .padding(.vertical)
                .frame(maxWidth: .infinity)
                .background(.secondary)
        }
        Form {
            Section("Social Media") {
                if let socialMedias = buddy.socialMedias {
                    ForEach(socialMedias) { socialMedia in
                        HStack {
                            SocialMedia.getImageBy(category: socialMedia.type)
                                .frame(width: 22, height: 22)
                            Divider()
                            Text(socialMedia.value)
                        }
                    }
                }
            }
            Section("Location") {
                if let longitude = buddy.longitude {
                    if let latitude = buddy.latitude {
                        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                        let startPosition = MapCameraPosition.region(
                            MKCoordinateRegion(
                                center: coordinate,
                                span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1))
                        )
                        Map(initialPosition: startPosition) {
                            Marker(buddy.locationName, coordinate: coordinate)
                        }
                        .mapStyle(.standard)
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
