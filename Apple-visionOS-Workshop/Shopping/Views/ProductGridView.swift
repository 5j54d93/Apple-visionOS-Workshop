//
//  ProductGridView.swift
//  Apple-visionOS-Workshop
//
//  Created by Ricky on 2025/2/12.
//


import SwiftUI

struct ProductGridView: View {
    
    @Environment(CartModel.self) private var cartModel
    
    let product: ProductModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Image(product.imageName)
                .resizable()
                .scaledToFit()
                .frame(height: 150)
                .padding(24)
                .frame(maxWidth: .infinity)
                .background(Material.thin, in: .rect(cornerRadius: 16))
            
            VStack(alignment: .leading) {
                VStack(alignment: .leading, spacing: 2) {
                    Text(product.name)
                        .font(.headline)
                        .lineLimit(2)
                        .layoutPriority(1)
                    
                    Text(product.subheadline)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .lineLimit(2)
                }
                .frame(height: 50, alignment: .top)
                
                Text(product.price.dollarFormatted())
                    .font(.title3)
                    .fontWeight(.semibold)
            }
        }
        .ornament(visibility: cartModel.items.isEmpty ? .hidden : .visible,
                  attachmentAnchor: .scene(.bottom)) {
            CartToolBar()
        }
        .animation(.smooth.speed(0.2), value: cartModel.items.count == 0)
    }
}
