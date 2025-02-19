//
//  SkySphereContentView.swift
//  Apple-visionOS-Workshop
//
//  Created by Ricky on 2025/2/12.
//

import SwiftUI

struct SkySphereContentView: View {
    
    @Environment(AppModel.self) private var appModel
    
    var body: some View {
        NavigationStack {
            SkySpherePickerView()
                .environment(appModel)
                .navigationTitle("Environment")
                .toolbar {
                    ToolbarItem(placement: .bottomOrnament) {
                        ToggleImmersiveSpaceButton(immersiveSpaceId: WindowType.skySphere.rawValue)
                            .environment(appModel)
                    }
                }
        }
        .background()
    }
}
