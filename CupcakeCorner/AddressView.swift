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
                    TextField("Name", text: $order.name)
                    TextField("Street Address", text: $order.streetAddress)
                    TextField("City", text: $order.city)
                    TextField("Zip", text: $order.zip)
                }
                Section {
                    NavigationLink("Check out"){
                        CheckoutView(order: order)
                    }
                }.disabled(order.hasValidAddress == false)
            }.navigationTitle("Delivery Details")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    AddressView(order: Order())
}
