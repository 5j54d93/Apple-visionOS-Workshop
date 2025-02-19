//
//  ShoppingContentView.swift
//  Apple-visionOS-Workshop
//
//  Created by Ricky on 2025/2/12.
//

import SwiftUI

struct ShoppingContentView: View {
    
    @Environment(\.openWindow) private var openWindow
    
    @State private var columnCount = 3
    @State private var searchText = ""
    
    private var filteredProducts: [ProductModel] {
        if searchText.isEmpty {
            ProductModel.allCases
        } else {
            ProductModel.allCases.filter {
                $0.name.contains(searchText)
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(
                    columns: Array(
                        repeating: GridItem(.flexible(), spacing: 16),
                        count: columnCount
                    ),
                    spacing: 32
                ) {
                    ForEach(filteredProducts, id: \.self) { product in
                        Button {
                            openWindow(id: WindowType.productDetail.rawValue, value: product)
                        } label: {
                            ProductGridView(product: product)
                                .contentShape(.rect)
                                .padding(8)
                        }
                        .buttonStyle(.plain)
                        .buttonBorderShape(.roundedRectangle)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 32)
            }
            .navigationTitle("Store")
            .background()
        }
        .searchable(text: $searchText, prompt: "Search Products")
        .onGeometryChange(for: CGSize.self, of: \.size) { newWindowSize in
            let idealGridWidth = CGFloat(300)
            columnCount = max(1, Int(newWindowSize.width / idealGridWidth))
        }
    }
}
