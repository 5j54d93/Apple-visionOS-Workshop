//
//  CartItemRow.swift
//  Apple-visionOS-Workshop
//
//  Created by Ricky on 2025/2/12.
//

import SwiftUI

struct CartItemRow: View {
    
    @Environment(CartModel.self) var cartModel
    let item: CartItem
    
    var body: some View {
        HStack(spacing: 16) {
            Image(item.imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 60)
            
            VStack(alignment: .leading, spacing: 8) {
                Text(item.name)
                    .font(.headline)
                
                Text(item.totalCost.dollarFormatted())
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .monospacedDigit()
                    .contentTransition(.numericText(value: item.totalCost))
                    .animation(.default, value: item.totalCost)
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            QuantityStepper(
                quantity: Binding(
                    get: { item.quantity },
                    set: { newValue in
                        cartModel.updateQuantity(for: item, isIncrement: newValue > item.quantity)
                    })
            )
        }
    }
}
