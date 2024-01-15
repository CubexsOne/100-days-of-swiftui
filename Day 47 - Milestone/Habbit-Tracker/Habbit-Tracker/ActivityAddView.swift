//
//  ActivityAddView.swift
//  Habbit-Tracker
//
//  Created by Pascal Sauer on 15.01.24.
//

import SwiftUI

let acitivityTypes: [ActivityType] = [
    .sport,
    .learning,
    .practicing,
    .other
]

struct ActivityAddView: View {
    @Environment(\.dismiss) var dismiss
    @State var activities: Activities
    
    @State private var selectedType = ActivityType.sport
    @State private var description = ""
    let created = Date.now
    @State private var duration = 0.0

    var body: some View {
        NavigationStack {
            Form {
                Section("Select your Category") {
                    Picker("Select your Category", selection: $selectedType) {
                        ForEach(acitivityTypes, id: \.self) { i in
                            Text("\(i.rawValue)")
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section("Description") {
                    TextField("Description", text: $description)
                }
                
                Section("Duration") {
                    Stepper("\(duration, format: .number)", value: $duration, in: 0.25...24, step: 0.25)
                }
                
                HStack(alignment: .center) {
                    Button("Save") {
                        let newActivity = Activity(id: UUID(), description: description, created: created, duration: duration, type: selectedType)
                        activities.list.append(newActivity)
                        dismiss()
                    }
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.blue)
                    .clipShape(.rect(cornerRadius: 16))
                }
                .listRowBackground(Color.clear)
            }
            .navigationTitle("Add new Activity")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    ActivityAddView(activities: Activities())
}
