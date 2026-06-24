//
//  String+Color.swift
//  EasyHTML
//
//  Created by Avijit Mondal
//

import SwiftUI

extension String {
    func toColor() -> Color {
        let hex = self.trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: "#", with: "")
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let r, g, b: Double
        switch hex.count {
        case 6: r = Double(int >> 16) / 255; g = Double((int >> 8) & 0xFF) / 255; b = Double(int & 0xFF) / 255
        default: return .black
        }
        return Color(.sRGB, red: r, green: g, blue: b, opacity: 1.0)
    }
}
