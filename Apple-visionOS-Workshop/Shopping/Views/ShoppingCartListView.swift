//
//  ShoppingCartListView.swift
//  Apple-visionOS-Workshop
//
//  Created by Ricky on 2025/2/12.
//


import SwiftUI

struct ShoppingCartListView: View {
    
    @Environment(\.dismiss) private var dismiss
    @Environment(CartModel.self) var cartModel
    
    @State private var shouldShowCheckoutSheet = false

    var body: some View {
        VStack {
            if cartModel.items.isEmpty {
                ContentUnavailableView(
                    "購物車空空的",
                    systemImage: "cart",
                    description: Text("去商店逛逛吧！")
                )
            } else {
                List {
                    Group {
                        Section {
                            ForEach(cartModel.items) { item in
                                CartItemRow(item: item)
                            }
                            .onDelete(perform: cartModel.removeItem)
                        }

                        Section {
                            totalCostView
                        }
                    }
                    .listRowInsets(
                        .init(top: 24, leading: 16, bottom: 24, trailing: 16))
                }
                .animation(.default, value: cartModel.items.count)
                .navigationTitle("我的購物車")
                .safeAreaInset(edge: .bottom) {
                    modalCheckoutButton
                }
                .sheet(isPresented: $shouldShowCheckoutSheet) {
                    CheckoutView()
                        .frame(minHeight: 450)
                }
            }
        }
        .animation(.default, value: cartModel.items.isEmpty)
    }
}

private extension ShoppingCartListView {
    var totalCostView: some View {
        HStack {
            Text("總計")
                .frame(maxWidth: .infinity, alignment: .leading)

            Text(cartModel.totalCost.dollarFormatted())
                .monospacedDigit()
                .contentTransition(
                    .numericText(value: cartModel.totalCost)
                )
                .animation(.default, value: cartModel.totalCost)
        }
        .font(.headline)
    }

    var modalCheckoutButton: some View {
        Button {
            shouldShowCheckoutSheet = true
        } label: {
            Label(
                "進行結帳",
                systemImage: "creditcard"
            )
            .frame(maxWidth: .infinity ,minHeight: 32)
            .font(.title2.bold())
        }
        .disabled(cartModel.totalCost.isZero)
        .buttonStyle(.borderedProminent)
        .padding(16)
    }
}
