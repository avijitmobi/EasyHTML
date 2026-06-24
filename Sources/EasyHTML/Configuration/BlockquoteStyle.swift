//
//  BlockquoteStyle.swift
//  EasyHTML
//
//  Created by Avijit Mondal
//

import Foundation

// Helper struct to replace the Tuple so it conforms to Equatable
public struct BlockquotePadding: Equatable {
    public let left: CGFloat
    public let vertical: CGFloat
    public let right: CGFloat
    
    public init(left: CGFloat, vertical: CGFloat, right: CGFloat) {
        self.left = left
        self.vertical = vertical
        self.right = right
    }
}

public struct BlockquoteStyle: Equatable {
    
    public let borderWidth: CGFloat
    public let borderColor: String
    public let backgroundColor: String
    public let textColor: String?
    public let fontStyle: String
    public let padding: BlockquotePadding // Changed from tuple
    public let borderRadius: CGFloat
    
    public init(
        borderWidth: CGFloat = 3,
        borderColor: String = "#007AFF",
        backgroundColor: String? = nil,
        textColor: String? = nil,
        fontStyle: String = "italic",
        padding: BlockquotePadding = BlockquotePadding(left: 16, vertical: 12, right: 0), // Updated default
        borderRadius: CGFloat = 0
    ) {
        self.borderWidth = borderWidth
        self.borderColor = borderColor
        self.backgroundColor = backgroundColor ?? "transparent"
        self.textColor = textColor
        self.fontStyle = fontStyle
        self.padding = padding
        self.borderRadius = borderRadius
    }
    
    // MARK: - Presets
    
    /// Default blockquote style with left border.
    public static let `default` = BlockquoteStyle()
    
    /// No styling.
    public static let plain = BlockquoteStyle(
        borderWidth: 0,
        fontStyle: "normal",
        padding: BlockquotePadding(left: 0, vertical: 0, right: 0) // Updated
    )
    
    /// Card-style blockquote with background.
    public static let card = BlockquoteStyle(
        borderWidth: 0,
        backgroundColor: "#F0F4F8",
        padding: BlockquotePadding(left: 16, vertical: 12, right: 16), // Updated
        borderRadius: 8
    )
    
    /// Subtle blockquote with light background.
    public static let subtle = BlockquoteStyle(
        borderWidth: 2,
        borderColor: "#CCCCCC",
        backgroundColor: "#FAFAFA",
        fontStyle: "normal"
    )
}
