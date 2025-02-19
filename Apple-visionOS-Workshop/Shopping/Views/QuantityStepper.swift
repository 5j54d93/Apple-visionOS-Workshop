//
//  QuantityStepper.swift
//  Apple-visionOS-Workshop
//
//  Created by Ricky on 2025/2/12.
//

import SwiftUI

private let buttonMinLength: CGFloat = 44

struct QuantityStepper: View {
    @Binding var quantity: Int
    
    var body: some View {
        HStack(spacing: 0) {
            button("減少數量", systemImage: "minus") {
                quantity -= 1
            }
            .disabled(quantity <= 0)
            
            Text(quantity.formatted())
                .fontWeight(.medium)
                .monospacedDigit()
                .contentTransition(.numericText(value: Double(quantity)))
                .animation(.default, value: quantity)
                .fixedSize(horizontal: true, vertical: false)
            
            button("增加數量", systemImage: "plus") {
                quantity += 1
            }
        }
        .labelStyle(.iconOnly)
        .background(Material.thick, in: .capsule)
        .buttonStyle(QuantityStepperButtonStyle())
    }
    
    func button(_ label: String, systemImage: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Label(label, systemImage: systemImage)
                .foregroundStyle(.secondary)
                .frame(minWidth: buttonMinLength, minHeight: buttonMinLength)
                .contentShape(.rect)
        }
        .help(label)
    }
}

private struct QuantityStepperButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .contentShape(.circle)
            .hoverEffect()
            .hoverEffect { hoverEffect, isHovering, geometryProxy in
                hoverEffect
                    .scaleEffect(isHovering ? 1.1 : 1)
            }
            .padding(6)
    }
}
