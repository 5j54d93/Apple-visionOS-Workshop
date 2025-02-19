//
//  Double+.swift
//  Apple-visionOS-Workshop
//
//  Created by Ricky on 2025/2/12.
//

import Foundation

extension Double {
    func dollarFormatted() -> String {
        "$" + formatted(.number.precision(.fractionLength(0)))
    }
}
