//
//  EntityTransformState.swift
//  Apple-visionOS-Workshop
//
//  Created by Ricky on 2025/2/18.
//

import SwiftUI

struct EntityTransformState {
    let orientation: simd_quatf
    let position: SIMD3<Float>
    let scale: SIMD3<Float>
}
