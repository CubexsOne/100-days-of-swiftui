//
//  ProspectEditView.swift
//  HotProspects
//
//  Created by Pascal Sauer on 01.03.24.
//

import SwiftUI

struct ProspectEditView: View {
    @Environment(\.dismiss) var dismiss
    @State var prospect: Prospect

    var body: some View {
        Form {
            TextField("Name", text: $prospect.name)
            TextField("Email address", text: $prospect.emailAddress)
            
            Toggle("Contacted", isOn: $prospect.isContacted)
        }
        .navigationTitle("Edit \(prospect.name)")
        .navigationBarBackButtonHidden()
        .toolbar {
            Button("Done") {
                dismiss()
            }
        }
    }
}
