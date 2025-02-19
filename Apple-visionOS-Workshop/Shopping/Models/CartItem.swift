//
//  CartItem.swift
//  Apple-visionOS-Workshop
//
//  Created by Ricky on 2025/2/12.
//

import Foundation
import SwiftUI

struct CartItem: Identifiable {
    var id = UUID()
    let name: String
    let price: Double
    var quantity: Int
    var imageName: String
    
    var totalCost: Double {
        price * Double(quantity)
    }
}

extension CartItem {
    init(product: ProductModel, quantity: Int) {
        self.name = product.name
        self.price = product.price
        self.imageName = product.imageName
        self.quantity = quantity
    }
}
