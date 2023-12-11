//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Henrieke Baunack on 12/8/23.
//

import SwiftUI

struct AddressView: View {
    // difference @Binding @State @Bindable
    
    @Bindable var order: Order
    
    var body: some View {
        NavigationStack{
            Form {
                Section {
                    TextField("Name", text: $order.address.name)
                    TextField("Street Address", text: $order.address.streetAddress)
                    TextField("City", text: $order.address.city)
                    TextField("Zip", text: $order.address.zip)
                }
                Section {
                    NavigationLink("Check out"){
                        CheckoutView(order: order).onAppear {
                            print("on appear!!")
                            
                            // we are gonna try to save the address to user defaults here
                            let encoder = JSONEncoder()
                            if let data = try? encoder.encode(order.address) {
                                UserDefaults.standard.set(data, forKey: "UserData")
                                print("Saved user data")
                            }
                        }
                    }.disabled(order.hasValidAddress == false)
                }.navigationTitle("Delivery Details")
                    .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}

#Preview {
    AddressView(order: Order())
}
