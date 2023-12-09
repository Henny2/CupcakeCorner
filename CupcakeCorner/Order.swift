//
//  Order.swift
//  CupcakeCorner
//
//  Created by Henrieke Baunack on 12/8/23.
//

import Foundation

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
}
