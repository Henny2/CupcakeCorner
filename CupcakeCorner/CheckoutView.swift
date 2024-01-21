//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Henrieke Baunack on 12/9/23.
//

import SwiftUI

struct CheckoutView: View {
    @State var order: Order
    
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false
    @State private var confirmationHeader = ""
    
    var body: some View {
        ScrollView{
            VStack{
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 233)
                .accessibilityHidden(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/) // hiding the picture or loading wheel from the voice over reader
                
                Text("Your total cost is \(order.cost, format: .currency(code: "USD"))")
                    .font(.title)
                
                Button("Place order"){
                    Task {
                        await placeOrder()
                    }
                }
                    .padding()
            }
        }
        .navigationTitle("Check out")
        .navigationBarTitleDisplayMode(.inline)
        .scrollBounceBehavior(.basedOnSize)
        .alert(confirmationHeader, isPresented: $showingConfirmation){
            Button("OK") {}
        }
        message: {
            Text(confirmationMessage)
        }
        
    }
    
    func placeOrder() async {
        guard let encoded = try? JSONEncoder().encode(order) else {
            print("Failed to decode Order")
            return
        }
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        //reqres.in website for testing
        
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            print(data)
            
            let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
            confirmationHeader = "Thank you!"
            confirmationMessage = "Your order for \(decodedOrder.quantity) \(Order.types[decodedOrder.type].lowercased()) cupcakes is on its way!"
            showingConfirmation = true
            // handle our result
        } catch {
            print("Check out failed: \(error.localizedDescription)")
            confirmationHeader = "There was a problem!"
            confirmationMessage = "Your order could not be placed. Please try again."
            showingConfirmation = true
        }
    }
}

#Preview {
    CheckoutView(order: Order())
}
