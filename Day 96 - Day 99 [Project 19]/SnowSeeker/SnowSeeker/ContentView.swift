//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Pascal Sauer on 20.03.24.
//

import SwiftUI

struct ContentView: View {
    enum Sorting {
        case none, alphabetical, country
    }

    let resorts: [Resort] = Resort.allResorts
    
    @State private var favorites = Favorites()
    @State private var searchText = ""
    @State private var sortingOrder = Sorting.none
    
    var filteredAndSortedResorts: [Resort] {
        var filteredResorts: [Resort] = []
        if searchText.isEmpty {
            filteredResorts = resorts
        } else {
            filteredResorts = resorts.filter { $0.name.localizedStandardContains(searchText) }
        }
        
        return filteredResorts.sorted { valA, valB in
            switch sortingOrder {
            case .none:
                false
            case .alphabetical:
                valA.name < valB.name
            case .country:
                valA.country < valB.country
            }
        }
    }

    var body: some View {
        NavigationSplitView {
            List(filteredAndSortedResorts) { resort in
                NavigationLink(value: resort) {
                    HStack {
                        Image(resort.country)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40, height: 25)
                            .clipShape(.rect(cornerRadius: 5))
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(.black, lineWidth: 1)
                            )
                        
                        VStack(alignment: .leading) {
                            Text(resort.name)
                                .font(.headline)
                            
                            Text("\(resort.runs) runs")
                                .foregroundStyle(.secondary)
                        }
                        
                        if favorites.contains(resort) {
                            Spacer()
                            
                            Image(systemName: "heart.fill")
                                .accessibilityLabel("This is a favorite resort")
                                .foregroundStyle(.red)
                        }
                    }
                }
            }
            .navigationTitle("Resorts")
            .navigationDestination(for: Resort.self) { resort in
                ResortView(resort: resort)
            }
            .searchable(text: $searchText, prompt: "Search for a resort")
            .toolbar {
                Menu("Sort", systemImage: "arrow.up.arrow.down") {
                    Picker("Sort", selection: $sortingOrder) {
                        Text("Default")
                            .tag(Sorting.none)

                        Text("Alphabetical")
                            .tag(Sorting.alphabetical)
                        
                        Text("Country")
                            .tag(Sorting.country)
                    }
                }
            }
        } detail: {
            WelcomeView()
        }
        .environment(favorites)
    }
}

#Preview {
    ContentView()
}
