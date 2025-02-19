//
//  Apple_visionOS_WorkshopApp.swift
//  Apple-visionOS-Workshop
//
//  Created by Ricky on 2025/2/11.
//

import SwiftUI

@main
struct Apple_visionOS_WorkshopApp: App {

    @State private var appModel = AppModel()
    @State private var cartModel = CartModel(items: [])

    var body: some Scene {
        WindowGroup(id: WindowType.main.rawValue) {
            ContentView()
                .environment(cartModel)
                .environment(appModel)
        }
        
        WindowGroup(id: WindowType.productDetail.rawValue, for: ProductModel.self) { $product in
            if let product {
                ProductDetailView(product: product)
                    .environment(cartModel)
            } else {
                Text("找不到商品")
            }
        }
        .defaultSize(width: 800, height: 600)
        
        WindowGroup(id: WindowType.productModel.rawValue, for: String.self) { $modelFileName in
            if let modelFileName {
                ProductModelView(modelFileName: modelFileName)
            } else {
                Text("找不到商品")
            }
        }
        .windowStyle(.volumetric)
        .defaultSize(width: 0.7, height: 0.7, depth: 0.7, in: .meters)
        
        ImmersiveSpace(id: WindowType.skySphere.rawValue) {
            SkySphereImmersiveView()
                .environment(appModel)
                .onAppear {
                    appModel.immersiveSpaceState = .open
                }
                .onDisappear {
                    appModel.immersiveSpaceState = .closed
                }
        }
        .immersionStyle(selection: .constant(.full), in: .full)
        
        ImmersiveSpace(id: WindowType.anchor.rawValue) {
            AnchorImmersiveView()
                .environment(appModel)
                .onAppear {
                    appModel.immersiveSpaceState = .open
                }
                .onDisappear {
                    appModel.immersiveSpaceState = .closed
                }
        }
        .immersionStyle(selection: .constant(.mixed), in: .mixed)
        
        ImmersiveSpace(id: WindowType.snowGlobe.rawValue) {
            SnowGlobeImmersiveView()
                .environment(appModel)
                .onAppear {
                    appModel.immersiveSpaceState = .open
                }
                .onDisappear {
                    appModel.immersiveSpaceState = .closed
                }
        }
        .immersionStyle(selection: .constant(.mixed), in: .mixed)
     }
}
