//
//  Activity.swift
//  Habbit-Tracker
//
//  Created by Pascal Sauer on 15.01.24.
//

import Foundation
import SwiftUI

enum ActivityType: String, Codable {
    case sport = "Sport", learning = "Learning", practicing = "Practicing", other = "Other"
}

struct Activity: Identifiable, Codable {
    let id: UUID
    let description: String
    let created: Date
    let duration: Double
    let type: ActivityType
    
    var formattedLaunchDate: String {
        created.formatted(date: .abbreviated, time: .omitted)
    }
}

@Observable
class Activities {
    let stateKey = "Habbits"
    var list: [Activity] {
        didSet {
            save()
        }
    }
    
    private let savePath = URL.documentsDirectory.appending(path: "Habbits")
    
    init() {
        if let data = try? Data(contentsOf: savePath) {
            if let habbits = try? JSONDecoder().decode([Activity].self, from: data) {
                self.list = habbits
                return
            }
        }
        
        list = [Activity]()
    }
    
    func save() {
        do {
            let data = try JSONEncoder().encode(list)
            try data.write(to: savePath)
        } catch {
            print("Failed to save activity data")
        }
    }
}
