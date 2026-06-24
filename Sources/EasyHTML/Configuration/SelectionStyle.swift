//
//  SelectionStyle.swift
//  EasyHTML
//
//  Created by Avijit Mondal
//

import Foundation

/// Configuration for text selection highlighting.
public struct SelectionStyle: Equatable {
    
    /// Selection background color.
    public let backgroundColor: String
    
    /// Selection text color. Use `nil` to keep original color.
    public let textColor: String?
    
    /// Creates a new selection style.
    public init(
        backgroundColor: String = "#007AFF",
        textColor: String? = nil
    ) {
        self.backgroundColor = backgroundColor
        self.textColor = textColor
    }
    
    // MARK: - Presets
    
    /// Default blue selection.
    public static let `default` = SelectionStyle()
    
    /// No visible selection.
    public static let none = SelectionStyle(backgroundColor: "transparent")
    
    /// Dark selection for light backgrounds.
    public static let dark = SelectionStyle(backgroundColor: "#333333", textColor: "#FFFFFF")
    
    /// Custom color selection.
    public static func custom(color: String) -> SelectionStyle {
        SelectionStyle(backgroundColor: color)
    }
}
