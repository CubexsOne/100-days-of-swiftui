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
    @State var socialMedias = [SocialMedia]()
    
    var body: some View {
        buddy.potrait
            .resizable()
            .scaledToFit()
        Form {
            Section("Personal Data") {
                TextField("Firstname", text: $buddy.firstName)
                TextField("Lastname", text: $buddy.lastName)
            }
            
            Section("Social Media") {
                ForEach(socialMedias.indices, id: \.self) { index in
                    HStack {
                        Picker("Chose social media icon", selection: $socialMedias[index].type) {
                            ForEach(SocialMedia.categories, id: \.self) { category in
                                SocialMedia.getImageBy(category: category)
                                    .tag(category)
                            }
                        }
                        .labelsHidden()
                        
                        Divider()
                        TextField("Value", text: $socialMedias[index].value)
                    }
                }
                .onDelete(perform: deleteSocialMedia)
                Button("Add social media", systemImage: "plus") {
                    socialMedias.append(SocialMedia(type: "none", value: ""))
                }
            }
            .onChange(of: socialMedias) { buddy.socialMedias = socialMedias }
            
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
    
    init(buddy: Buddy) {
        self.buddy = buddy
        if let socialMedias = buddy.socialMedias {
            _socialMedias = State(initialValue: socialMedias)
        }
    }
    
    func deleteSocialMedia(offsets: IndexSet) {
        for index in offsets {
            socialMedias.remove(at: index)
        }
    }
}
