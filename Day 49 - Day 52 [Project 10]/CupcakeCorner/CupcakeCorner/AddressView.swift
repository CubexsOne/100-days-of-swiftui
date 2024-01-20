//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Pascal Sauer on 18.01.24.
//

import SwiftUI

struct AddressView: View {
    @Bindable var order: Order

    var body: some View {
        Form {
            Section {
                TextField("Name", text: $order.deliveryAddress.name)
                TextField("Street Address", text: $order.deliveryAddress.streetAddress)
                TextField("City", text: $order.deliveryAddress.city)
                TextField("Zip", text: $order.deliveryAddress.zip)
            }
            
            Section {
                NavigationLink("Check out") {
                    CheckoutView(order: order)
                }
            }
            .disabled(order.deliveryAddress.hasValidAddress == false)
        }
        .navigationTitle("Delivery details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    AddressView(order: Order())
}
