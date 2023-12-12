//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Henrieke Baunack on 12/4/23.
//

import SwiftUI

struct ContentView: View {
    @State private var order = Order()
    
    var body: some View {
        NavigationStack{
            Form {
                Section {
                    Picker("Select your cake type", selection: $order.type){
                        ForEach(Order.types.indices, id: \.self){
                            Text(Order.types[$0])
                        }
                    }
                    Stepper("Number of cakes: \(order.quantity)", value: $order.quantity, in: 3...20)
                }
                Section {
                    Toggle("Any special requests?", isOn: $order.specialRequestEnabled)
                    if order.specialRequestEnabled {
                        Toggle("Add extra frosting", isOn: $order.extraFrosting)
                        Toggle("Add extra sprinkles", isOn: $order.addSprinkles)
                    }
                }
                Section {
                    NavigationLink("Delivery Details") {
                        AddressView(order: order).onAppear{
                            let decoder = JSONDecoder()
                            if let savedUserInfo = UserDefaults.standard.data(forKey: "UserData") {
                                if let decodedInfo = try? decoder.decode(Address.self, from: savedUserInfo)
                                {
                                    print("get user data")
                                    print(decodedInfo)
                                    order.address = decodedInfo
                                    // have to set this to the user's address
                                    return
                                }
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle("CupCakeCorner")
    }
}

#Preview {
    ContentView()
}
