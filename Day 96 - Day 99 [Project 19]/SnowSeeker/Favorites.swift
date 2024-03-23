//
//  Favorites.swift
//  SnowSeeker
//
//  Created by Pascal Sauer on 22.03.24.
//

import SwiftUI


@Observable
class Favorites {
    private var resorts: Set<String>
    private let key = "Favorites"
    
    init() {
        if let data = try? Data(contentsOf: URL.documentsDirectory.appending(path: key)) {
            if let resorts = try? JSONDecoder().decode(Set<String>.self, from: data) {
                self.resorts = resorts
                return
            }
        }

        self.resorts = []
    }
    
    func contains(_ resort: Resort) -> Bool {
        resorts.contains(resort.id)
    }
    
    func add(_ resort: Resort) {
        resorts.insert(resort.id)
        save()
    }
    
    func remove(_ resort: Resort) {
        resorts.remove(resort.id)
        save()
    }
    
    func save() {
        do {
            let data = try JSONEncoder().encode(resorts)
            try data.write(to: URL.documentsDirectory.appending(path: key))
        } catch {
            print("Failed to save activity data")
        }
    }
}
