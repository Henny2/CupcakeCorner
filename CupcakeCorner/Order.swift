//
//  Order.swift
//  CupcakeCorner
//
//  Created by Henrieke Baunack on 12/8/23.
//

import Foundation
import Observation

@Observable
class Order: Codable {
    
    enum CodingKeys: String, CodingKey {
        case _type = "type"
        case _quantity = "quantity"
        case _specialRequestEnabled = "specialRequestEnabled"
        case _addSprinkles = "addSprinkles"
        case _extraFrosting = "extraFrosting"
        case _name = "name"
        case _zip = "zip"
        case _city = "city"
        case _streetAddress = "streetAddress"
        
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
    
    var name = ""
    var streetAddress = ""
    var city = ""
    var zip = ""
    
    var hasValidAddress: Bool {
        if name.isEmpty || streetAddress.isEmpty || city.isEmpty || zip.isEmpty {
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
