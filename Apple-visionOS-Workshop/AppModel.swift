//
//  AppModel.swift
//  Apple-visionOS-Workshop
//
//  Created by Ricky on 2025/2/11.
//

import SwiftUI

/// Maintains app-wide state
@MainActor
@Observable
class AppModel {
    enum ImmersiveSpaceState {
        case closed
        case inTransition
        case open
    }
    var immersiveSpaceState = ImmersiveSpaceState.closed
    var skySphereType = SkySphereType.allCases.first
}
