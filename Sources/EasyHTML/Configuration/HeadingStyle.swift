//
//  HeadingStyle.swift
//  EasyHTML
//
//  Created by Avijit Mondal
//

import Foundation

/// Configuration for heading (h1-h6) styling.
public struct HeadingStyle: Equatable {
    
    /// Whether headings use a different color from body text.
    public let useCustomColor: Bool
    
    /// Font weight for all headings.
    public let weight: String
    
    /// Text transform for headings.
    public let textTransform: String
    
    /// Size multipliers for h1 through h6 relative to base font size.
    public let sizeMultipliers: [CGFloat]
    
    /// Creates a new heading style.
    /// - Parameters:
    ///   - useCustomColor: Use custom heading color. Default is false.
    ///   - weight: Font weight. Default is "bold".
    ///   - textTransform: Text transform. Default is "none".
    ///   - sizeMultipliers: Size multipliers for h1-h6. Default is [2.0, 1.6, 1.3, 1.1, 1.0, 0.9].
    public init(
        useCustomColor: Bool = false,
        weight: String = "bold",
        textTransform: String = "none",
        sizeMultipliers: [CGFloat]? = nil
    ) {
        self.useCustomColor = useCustomColor
        self.weight = weight
        self.textTransform = textTransform
        self.sizeMultipliers = sizeMultipliers ?? [2.0, 1.6, 1.3, 1.1, 1.0, 0.9]
    }
    
    // MARK: - Presets
    
    /// Default heading style.
    public static let `default` = HeadingStyle()
    
    /// Uppercase headings.
    public static let uppercase = HeadingStyle(textTransform: "uppercase")
    
    /// Lighter weight headings.
    public static let light = HeadingStyle(weight: "300")
    
    /// Extra large headings.
    public static let display = HeadingStyle(sizeMultipliers: [2.5, 2.0, 1.6, 1.3, 1.1, 1.0])
}

// Private property for letter spacing (not in init to keep public API clean)
extension HeadingStyle {
    var letterSpacing: CGFloat? {
        if textTransform == "uppercase" { return 1.0 }
        return nil
    }
}
