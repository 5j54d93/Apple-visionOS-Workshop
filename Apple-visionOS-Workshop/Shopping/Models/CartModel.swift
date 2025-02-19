//
//  CartModel.swift
//  Apple-visionOS-Workshop
//
//  Created by Ricky on 2025/2/12.
//


import Foundation
import Observation

@Observable
@MainActor
final class CartModel {
    private(set) var items: [CartItem]
    
    init(items: [CartItem]) {
        self.items = items
    }
    
    var totalCost: Double {
        items.reduce(0) { $0 + $1.totalCost }
    }
    
    func updateQuantity(for item: CartItem, isIncrement: Bool) {
        guard let index = items.firstIndex(where: { $0.id == item.id }) else {
            print("⚠️ tried to update an unlisted item")
            return
        }
        
        items[index].quantity += isIncrement ? 1 : -1
        if items[index].quantity == 0 {
            items.remove(at: index)
        }
    }
    
    func addItem(_ product: ProductModel) {
        if let index = items.firstIndex(where: { $0.name == product.name }) {
            items[index].quantity += 1
        } else {
            items.append(CartItem(product: product, quantity: 1))
        }
    }
    
    func removeItem(at indexSet: IndexSet) {
        items.remove(atOffsets: indexSet)
    }
}
