//
//  CartToolBar.swift
//  Apple-visionOS-Workshop
//
//  Created by Ricky on 2025/2/12.
//

import SwiftUI

struct CartToolBar: View {
    
    @Environment(CartModel.self) private var cartModel
    
    @State private var shouldShowCart: Bool = false
    
    var itemCount: Int {
        cartModel.items.count
    }
    
    var body: some View {
        Button {
            shouldShowCart = true
        } label: {
            HStack(spacing: 16) {
                Image(systemName: "cart.fill")
                    .imageScale(.large)
                    .padding(.leading)
                    .overlay(alignment: .topTrailing) {
                        Image(systemName: "\(itemCount).circle.fill")
                            .foregroundStyle(.primary, .red)
                            .imageScale(.large)
                            .offset(x: 10, y: -10)
                    }
                
                Text(cartModel.totalCost.dollarFormatted())
                    .font(.title3.bold())
                    .frame(minWidth: 120, alignment: .leading)
                
                Spacer(minLength: 40)
                
                Text("檢視")
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(Material.thin, in: .capsule)
            }
            .padding(8)
        }
        .buttonStyle(.plain)
        .buttonBorderShape(.capsule)
        .padding(8)
        .sheet(isPresented: $shouldShowCart) {
            NavigationStack {
                ShoppingCartListView()
                    .environment(cartModel)
                    .toolbar {
                        ToolbarItem(placement: .topBarLeading) {
                            Button("取消") {
                                shouldShowCart = false
                            }
                        }
                    }
            }
        }
        .padding(8)
        .glassBackgroundEffect()
        .padding(8)
    }
}
