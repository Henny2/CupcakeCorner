//
//  Order.swift
//  CupcakeCorner
//
//  Created by Henrieke Baunack on 12/8/23.
//

import Foundation
import Observation

@Observable
class Order {
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
}
