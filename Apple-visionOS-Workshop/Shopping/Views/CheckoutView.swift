//
//  CheckoutView.swift
//  Apple-visionOS-Workshop
//
//  Created by Ricky on 2025/2/12.
//

import SwiftUI

struct CheckoutView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            Text("💸 請想像一個結帳頁面 💸")
                .font(.title2)
            Button("OK") {
                dismiss()
            }
            .padding()
            .font(.title3.bold())
            .buttonStyle(.bordered)
        }
        .padding()
    }
}
