//
//  View+EasyHTML.swift
//  EasyHTML
//
//  Created by Avijit Mondal
//

import SwiftUI
import UIKit

extension View {
    
    /// Applies a background color from a hex string.
    func background(hex: String) -> some View {
        self.background(hex.toColor())
    }
}

extension String {
    /// Converts a hex string (e.g., "#FF0000", "#FF000080", "#F00", "FF0000") to a SwiftUI Color. Supports 3, 6, or 8 hex digits.
    func toColor() -> Color {
        let hex = self.trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: "#", with: "")
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let r, g, b, a: Double
        switch hex.count {
        case 6:
            r = Double((int >> 16) & 0xFF) / 255
            g = Double((int >> 8) & 0xFF) / 255
            b = Double(int & 0xFF) / 255
            a = 1.0
        case 8:
            r = Double((int >> 24) & 0xFF) / 255
            g = Double((int >> 16) & 0xFF) / 255
            b = Double((int >> 8) & 0xFF) / 255
            a = Double(int & 0xFF) / 255
        case 3: // e.g. F00
            r = Double((int >> 8) & 0xF) / 15
            g = Double((int >> 4) & 0xF) / 15
            b = Double(int & 0xF) / 15
            a = 1.0
        default:
            return Color.clear
        }
        return Color(.sRGB, red: r, green: g, blue: b, opacity: a)
    }
}
