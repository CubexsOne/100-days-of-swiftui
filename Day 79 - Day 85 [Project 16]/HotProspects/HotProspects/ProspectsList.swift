//
//  ProspectsList.swift
//  HotProspects
//
//  Created by Pascal Sauer on 01.03.24.
//

import SwiftData
import SwiftUI
import UserNotifications

struct ProspectsList: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: \Prospect.name)  var prospects: [Prospect]
    @State private var selectedProspects = Set<Prospect>()
    
    let filter: FilterType

    var body: some View {
        List(prospects, selection: $selectedProspects) { prospect in
            NavigationLink {
                ProspectEditView(prospect: prospect)
            } label: {
                HStack {
                    VStack(alignment: .leading) {
                        Text(prospect.name)
                            .font(.headline)
                        
                        Text(prospect.emailAddress)
                            .foregroundStyle(.secondary)
                    }
                    Spacer()
                    if prospect.isContacted && filter == .none {
                        Image(systemName: "checkmark")
                            .foregroundStyle(.green)
                    }
                }
            }
            .swipeActions {
                Button("Delete", systemImage: "trash", role: .destructive) {
                    modelContext.delete(prospect)
                }

                if prospect.isContacted {
                    Button("Mark Uncontacted", systemImage: "person.crop.circle.badge.xmark") {
                        prospect.isContacted.toggle()
                    }
                    .tint(.blue)
                } else {
                    Button("Mark Contacted", systemImage: "person.crop.circle.fill.badge.checkmark") {
                        prospect.isContacted.toggle()
                    }
                    .tint(.green)
                    
                    Button("Remind Me", systemImage: "bell") {
                        addNotification(for: prospect)
                    }
                    .tint(.orange)
                }
            }
            .tag(prospect)
        }
    }
    
    init(filter: FilterType, sortOrder: [SortDescriptor<Prospect>]) {
        self.filter = filter
        
        if filter != .none {
            let showContactedOnly = filter == .contacted
            
            _prospects = Query(
                filter: #Predicate {
                    $0.isContacted == showContactedOnly
                },
                sort: showContactedOnly ? sortOrder : [SortDescriptor(\Prospect.name)])
        }
    }
    
    func addNotification(for prospect: Prospect) {
        let center = UNUserNotificationCenter.current()
        
        let addRequest = {
            let content = UNMutableNotificationContent()
            content.title = "Contact \(prospect.name)"
            content.subtitle = prospect.emailAddress
            content.sound = UNNotificationSound.default
            
            var dateComponents = DateComponents()
            dateComponents.hour = 9
            
//            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            
            center.add(request)
        }
        
        center.getNotificationSettings { settings in
            if settings.authorizationStatus == .authorized {
                addRequest()
            } else {
                center.requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        addRequest()
                    } else if let error {
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
}

#Preview {
    ProspectsList(filter: .none, sortOrder: [])
        .modelContainer(for: Prospect.self)
}
