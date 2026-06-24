//
//  HorizontalRuleStyle.swift
//  EasyHTML
//
//  Created by Avijit Mondal
//

import Foundation

/// Configuration for horizontal rule (<hr>) styling.
public struct HorizontalRuleStyle: Equatable {
    
    /// Border color.
    public let color: String
    
    /// Border height in pixels.
    public let height: CGFloat
    
    /// Top and bottom margin in pixels.
    public let margin: CGFloat
    
    /// Width: "100%" or specific value like "50%".
    public let width: String
    
    /// Creates a new horizontal rule style.
    public init(
        color: String = "#E0E0E0",
        height: CGFloat = 1,
        margin: CGFloat = 16,
        width: String = "100%"
    ) {
        self.color = color
        self.height = height
        self.margin = margin
        self.width = width
    }
    
    // MARK: - Presets
    
    /// Default horizontal rule.
    public static let `default` = HorizontalRuleStyle()
    
    /// No visible rule.
    public static let hidden = HorizontalRuleStyle(color: "transparent", height: 0, margin: 0)
    
    /// Thick decorative rule.
    public static let thick = HorizontalRuleStyle(height: 3, width: "25%")
    
    /// Subtle dotted rule.
    public static let subtle = HorizontalRuleStyle(color: "#F0F0F0", margin: 8)
}
