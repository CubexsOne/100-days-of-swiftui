//
//  Order.swift
//  CupcakeCorner
//
//  Created by Pascal Sauer on 18.01.24.
//

import Foundation

extension String {
    func isTrimmedEmpty() -> Bool {
        self.trimmingCharacters(in: .whitespaces).isEmpty
    }
}

@Observable
class Order: Codable {
    enum CodingKeys: String, CodingKey {
        case _type = "type"
        case _quantity = "quantity"
        case _specialRequestEnabled = "specialRequestEnabled"
        case _extraFrosting = "extraFrosting"
        case _addSprinkles = "addSprinkles"
        case _deliveryAddress = "deliveryAddress"
    }

    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    private let saveAddressPath = URL.documentsDirectory.appending(path: "Order.deliveryAddress")
    
    var type = 0
    var quantity = 3
    
    var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    var extraFrosting = false
    var addSprinkles = false
    
    var deliveryAddress = DeliveryAddress() {
        didSet {
            saveAddress()
        }
    }
    
    var cost: Decimal {
        var cost = Decimal(quantity) * 2
        
        cost += Decimal(type) / 2
        
        if extraFrosting {
            cost += Decimal(quantity)
        }
        
        if addSprinkles {
            cost += Decimal(quantity) / 2
        }
        
        return cost
    }
    
    init() {
        if let data = try? Data(contentsOf: saveAddressPath) {
            if let decoded = try? JSONDecoder().decode(DeliveryAddress.self, from: data) {
                self.deliveryAddress = decoded
                return
            }
        }
        
        deliveryAddress = DeliveryAddress()
    }
    
    func saveAddress() {
        do {
            let data = try JSONEncoder().encode(deliveryAddress)
            try data.write(to: saveAddressPath)
        } catch {
            print("Failed to save activity data")
        }
    }
}

struct DeliveryAddress: Codable {
    var name = ""
    var streetAddress = ""
    var city = ""
    var zip = ""
    
    var hasValidAddress: Bool {
        if name.isTrimmedEmpty() || streetAddress.isTrimmedEmpty() || city.isTrimmedEmpty() || zip.isTrimmedEmpty() {
            return false
        }
        
        return true
    }
}
