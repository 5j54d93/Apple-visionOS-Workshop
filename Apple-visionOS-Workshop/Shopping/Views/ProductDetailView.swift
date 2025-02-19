//
//  ProductDetailView.swift
//  Apple-visionOS-Workshop
//
//  Created by Ricky on 2025/2/12.
//


import SwiftUI

struct ProductDetailView: View {
    
    @Environment(\.openWindow) private var openWindow
    @Environment(CartModel.self) private var cartModel
    
    let product: ProductModel
    
    var body: some View {
        VStack(spacing: 16) {
            HStack(alignment: .top, spacing: 24) {
                productVisual
                
                ScrollView {
                    productInfomationView
                }
            }
        }
        .padding(24)
        .background()
        .buttonStyle(.borderedProminent)
        .toolbar {
            ToolbarItemGroup(placement: .bottomOrnament) {
                showInSpaceButton
                addToCartButton
            }
        }
    }
}

// MARK: - Button subviews
private extension ProductDetailView {
    
    var showInSpaceButton: some View {
        Button {
            openWindow(id: WindowType.productModel.rawValue, value: product.usdzFileName)
        } label: {
            HStack {
                Image(systemName: "arkit")
                    .frame(minHeight: 32)
                
                Text("於空間中顯示")
                    .fixedSize(horizontal: true, vertical: false)
            }
            .frame(maxWidth: .infinity ,minHeight: 32)
            .font(.title2.bold())
        }
    }
    
    var addToCartButton: some View {
        let quantity = cartModel.items.first(where: { $0.name == product.name })?.quantity ?? 0
        let isInCart = quantity > 0
        
        return Button {
            cartModel.addItem(product)
        } label: {
            HStack {
                Image(systemName: isInCart ? "plus" : "cart.badge.plus")
                    .contentTransition(.symbolEffect)
                
                addToCartText(quantity: quantity)
                    .fixedSize(horizontal: true, vertical: false)
            }
            .frame(maxWidth: .infinity ,minHeight: 32)
            .font(.title2.bold())
        }
    }
    
    @ViewBuilder
    func addToCartText(quantity: Int) -> some View {
        if quantity > 0 {
            Text("加購（購物車內有 \(quantity) 個）")
                .monospacedDigit()
                .contentTransition(.numericText(countsDown: false))
                .transition(.opacity.animation(.easeIn.delay(0.1)))
        } else {
            Text("加入購物車")
                .transition(.blurReplace.animation(.spring))
        }
    }
}

// MARK: - Product subviews
private extension ProductDetailView {
    var productVisual: some View {
        Image(product.imageName)
            .resizable()
            .scaledToFit()
            .padding(24)
            .containerRelativeFrame(.vertical, count: 2, span: 1, spacing: 0)
            .frame(maxWidth: .infinity)
            .background(Material.thin, in: .rect(cornerRadius: 24))
    }
    
    var productTitleView: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(product.name)
                .font(.title)
                .fontWeight(.semibold)
            
            Text(product.subheadline)
                .font(.title3)
                .fontWeight(.medium)
                .foregroundStyle(.secondary)
        }
    }
    
    var productInfomationView: some View {
        VStack(alignment: .leading, spacing: 16){
            productTitleView
            
            Text(product.price.dollarFormatted())
                .font(.title2)
                .bold()
            
            Text(product.description)
        }
    }
}
