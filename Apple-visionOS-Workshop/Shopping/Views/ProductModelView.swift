//
//  ProductModelView.swift
//  Apple-visionOS-Workshop
//
//  Created by Ricky on 2025/2/12.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ProductModelView: View {
    
    let modelFileName: String
    
    var body: some View {
        Model3D(named: modelFileName, bundle: realityKitContentBundle) { model in
            model
                .resizable()
                .scaledToFit()
        } placeholder: {
            loadingView
        }
        .frame(maxDepth: .infinity, alignment: .front)
    }
    
    var loadingView: some View {
        VStack(spacing: 16) {
            Text("讀取模型中...")
                .font(.title.bold())
            ProgressView()
                .controlSize(.extraLarge)
        }
        .padding(48)
    }
}
