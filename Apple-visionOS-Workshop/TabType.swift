//
//  TabType.swift
//  Apple-visionOS-Workshop
//
//  Created by Ricky on 2025/2/11.
//

import SwiftUI

enum TabType: CaseIterable {
    case shopping
    case skySphere
    case anchor
    case snowGlobe
}

extension TabType {
    
    var displayName: String {
        switch self {
        case .shopping: "Shopping"
        case .skySphere: "SkySphere"
        case .anchor: "Anchor"
        case .snowGlobe: "Snow Globe"
        }
    }
    
    var systemImage: String {
        switch self {
        case .shopping: "cart"
        case .skySphere: "rotate.3d"
        case .anchor: "mappin.and.ellipse"
        case .snowGlobe: "snowflake"
        }
    }
    
    @ViewBuilder
    var content: some View {
        switch self {
        case .shopping: ShoppingContentView()
        case .skySphere: SkySphereContentView()
        case .anchor: ToggleImmersiveSpaceButton(immersiveSpaceId: WindowType.anchor.rawValue)
        case .snowGlobe: ToggleImmersiveSpaceButton(immersiveSpaceId: WindowType.snowGlobe.rawValue)
        }
    }
}
