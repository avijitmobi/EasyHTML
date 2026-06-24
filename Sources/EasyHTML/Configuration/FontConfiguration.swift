//
//  FontConfiguration.swift
//  EasyHTML
//
//  Created by Avijit Mondal
//

import Foundation

/// Configuration for all font-related settings in the HTML view.
public struct FontConfiguration: Equatable {
    
    /// The font family name. Use `nil` for system font.
    public let familyName: String?
    
    /// The base font size in points.
    public let size: CGFloat
    
    /// CSS font-weight (e.g., "normal", "bold", "100"-"900").
    public let weight: String
    
    /// Font style: "normal" or "italic".
    public let style: String
    
    /// Letter spacing in pixels. Use `nil` for default.
    public let letterSpacing: CGFloat?
    
    /// Word spacing in pixels. Use `nil` for default.
    public let wordSpacing: CGFloat?
    
    /// Text transform: "none", "uppercase", "lowercase", "capitalize".
    public let textTransform: String
    
    /// Text decoration: "none", "underline", "line-through", "overline".
    public let textDecoration: String
    
    /// Text alignment: "left", "right", "center", "justify".
    public let textAlign: String
    
    /// Creates a new font configuration.
    /// - Parameters:
    ///   - familyName: Font family name. Use `nil` for system font.
    ///   - size: Font size in points. Default is 16.
    ///   - weight: CSS font weight. Default is "normal".
    ///   - style: Font style. Default is "normal".
    ///   - letterSpacing: Letter spacing in pixels. Default is nil.
    ///   - wordSpacing: Word spacing in pixels. Default is nil.
    ///   - textTransform: Text transform. Default is "none".
    ///   - textDecoration: Text decoration. Default is "none".
    ///   - textAlign: Text alignment. Default is "left".
    public init(
        familyName: String? = nil,
        size: CGFloat = 16,
        weight: String = "normal",
        style: String = "normal",
        letterSpacing: CGFloat? = nil,
        wordSpacing: CGFloat? = nil,
        textTransform: String = "none",
        textDecoration: String = "none",
        textAlign: String = "left"
    ) {
        self.familyName = familyName
        self.size = size
        self.weight = weight
        self.style = style
        self.letterSpacing = letterSpacing
        self.wordSpacing = wordSpacing
        self.textTransform = textTransform
        self.textDecoration = textDecoration
        self.textAlign = textAlign
    }
    
    // MARK: - Presets
    
    /// System default font.
    public static let system = FontConfiguration()
    
    /// System font with bold weight.
    public static let systemBold = FontConfiguration(weight: "bold")
    
    /// System font in italic style.
    public static let systemItalic = FontConfiguration(style: "italic")
    
    /// Serif font (Georgia).
    public static let serif = FontConfiguration(familyName: "Georgia")
    
    /// Serif font with bold weight.
    public static let serifBold = FontConfiguration(familyName: "Georgia", weight: "bold")
    
    /// Monospace font (Menlo).
    public static let monospace = FontConfiguration(familyName: "Menlo", size: 14)
    
    /// Sans-serif font (Helvetica/Arial).
    public static let sansSerif = FontConfiguration(familyName: "Helvetica Neue")
    
    /// Uppercase small text, useful for labels.
    public static let label = FontConfiguration(
        size: 12,
        weight: "600",
        letterSpacing: 0.5, 
        textTransform: "uppercase"
    )
    
    /// Creates a custom font configuration with a specific family.
    /// - Parameters:
    ///   - familyName: The font family name.
    ///   - size: Font size. Default is 16.
    ///   - weight: Font weight. Default is "normal".
    public static func custom(
        familyName: String,
        size: CGFloat = 16,
        weight: String = "normal"
    ) -> FontConfiguration {
        FontConfiguration(familyName: familyName, size: size, weight: weight)
    }
    
    // MARK: - Internal
    
    /// Returns the CSS font-family value.
    var cssFontFamily: String {
        if let familyName = familyName {
            return "'\(familyName)'"
        }
        return "-apple-system, BlinkMacSystemFont, 'SF Pro Text', 'Helvetica Neue', Arial, sans-serif"
    }
}

