//
//  ContentView.swift
//  Apple-visionOS-Workshop
//
//  Created by Ricky on 2025/2/11.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ContentView: View {
    
    @Environment(CartModel.self) private var cartModel
    @Environment(AppModel.self) private var appModel
    
    @State private var tabSelection = TabType.allCases.first
    
    var body: some View {
        TabView(selection: $tabSelection) {
            ForEach(TabType.allCases, id: \.self) { tabType in
                Tab(tabType.displayName, systemImage: tabType.systemImage, value: tabType) {
                    tabType.content
                        .environment(appModel)
                        .environment(cartModel)
                }
            }
        }
    }
}
