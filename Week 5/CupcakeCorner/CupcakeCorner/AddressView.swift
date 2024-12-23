//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Roman Golub on 10.10.2024.
//

import SwiftUI

struct AddressView: View {
    @ObservedObject var orderManager: OrderManager
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $orderManager.order.name)
                TextField("Street Address", text: $orderManager.order.streetAddress)
                TextField("City", text: $orderManager.order.city)
                TextField("Zip", text: $orderManager.order.zip)
            }

            Section {
                NavigationLink {
                    CheckoutView(orderManager: orderManager)
                } label: {
                    Text("Check out")
                }
            }
            .disabled(orderManager.order.hasValidAddress == false)

        }
        .navigationTitle("Delivery details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(orderManager: OrderManager())
    }
}
