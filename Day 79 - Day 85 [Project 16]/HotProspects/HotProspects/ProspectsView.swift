//
//  ProspectsView.swift
//  HotProspects
//
//  Created by Pascal Sauer on 26.02.24.
//

import SwiftData
import SwiftUI

struct ProspectsView: View {
    enum FilterType {
        case none, contacted, uncontacted
    }
    
    @Environment(\.modelContext) var modelContext
    @Query(sort: \Prospect.name) var prospects: [Prospect]
    let filter: FilterType
    
    var title: String {
        switch filter {
        case .none:
            "Everyone"
        case .contacted:
            "Contacted People"
        case .uncontacted:
            "Uncontacted People"
        }
    }
    var body: some View {
        NavigationStack {
            Text("People: \(prospects.count)")
                .navigationTitle(title)
                .toolbar {
                    Button("Scan", systemImage: "qrcode.viewfinder") {
                        let prospect = Prospect(name: "Cubi", emailAddress: "cubi@mail.nice", isContacted: false)
                        modelContext.insert(prospect)
                    }
                }
        }
    }
}

#Preview {
    ProspectsView(filter: .none)
        .modelContainer(for: Prospect.self)
}
