//
//  Order.swift
//  CupcakeCorner
//
//  Created by Henrieke Baunack on 12/8/23.
//

// why we cannot store the user address in @AppStorage
// Important: @AppStorage writes your data to UserDefaults, which is not secure storage.
// As a result, you should not save any personal data using @AppStorage, because it’s relatively easy to extract.

import Foundation
import Observation


struct Address: Codable {
//    enum CodingKeys: String, CodingKey {
//        case _name = "name"
//        case _zip = "zip"
//        case _city = "city"
//        case _streetAddress = "streetAddress"
//        
//    }
    var name = ""
    var streetAddress = ""
    var city = ""
    var zip = ""
}

@Observable
class Order: Codable {
    
    enum CodingKeys: String, CodingKey {
        case _type = "type"
        case _quantity = "quantity"
        case _specialRequestEnabled = "specialRequestEnabled"
        case _addSprinkles = "addSprinkles"
        case _extraFrosting = "extraFrosting"
//        case _name = "name"
//        case _zip = "zip"
//        case _city = "city"
//        case _streetAddress = "streetAddress"
        
    }
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
    var type = 0 // vanilla
    var quantity = 3
    var specialRequestEnabled = false {
        didSet {
                addSprinkles = false
                extraFrosting = false 
        }
    }
    var extraFrosting = false
    var addSprinkles = false 
    
//    var name = ""
//    var streetAddress = ""
//    var city = ""
//    var zip = ""
    var address = Address()
    
    var hasValidAddress: Bool {
        address.name = address.name.trimmingCharacters(in: .whitespacesAndNewlines)
        address.streetAddress = address.streetAddress.trimmingCharacters(in: .whitespacesAndNewlines)
        address.zip = address.zip.trimmingCharacters(in: .whitespacesAndNewlines)
        address.city = address.city.trimmingCharacters(in: .whitespacesAndNewlines)
        if address.name.isEmpty || address.streetAddress.isEmpty || address.city.isEmpty || address.zip.isEmpty {
            return false
        }
        return true
    }
    
    var cost: Decimal {
        // 2$ per cake
        var cost = Decimal(quantity) * 2
        
        // complicated costs cost more
        cost += Decimal(type)/2
        
        // 1$/cake per cake per extra frosting
        if extraFrosting {
            cost += Decimal(quantity) * 1
        }
        
        // 0.5$/cake for sprinkles
        if addSprinkles {
            cost += Decimal(quantity) * 0.5
        }
        
        return cost
    }
}
