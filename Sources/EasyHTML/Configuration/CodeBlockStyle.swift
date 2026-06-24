//
//  CodeBlockStyle.swift
//  EasyHTML
//
//  Created by Avijit Mondal
//

import Foundation

// Helper struct to replace the Tuple so it conforms to Equatable
public struct InlinePadding: Equatable {
    public let horizontal: CGFloat
    public let vertical: CGFloat
    public init(horizontal: CGFloat, vertical: CGFloat) {
        self.horizontal = horizontal
        self.vertical = vertical
    }
}

public struct CodeBlockStyle: Equatable {
    
    public let fontFamily: String
    public let sizeMultiplier: CGFloat
    public let inlineBackground: String
    public let inlineTextColor: String
    public let inlineBorderRadius: CGFloat
    public let inlinePadding: InlinePadding // Changed from tuple
    public let blockBackground: String
    public let blockTextColor: String
    public let blockBorderRadius: CGFloat
    public let blockPadding: CGFloat
    public let blockBorderAccent: Bool
    public let blockBorderColor: String
    
    public init(
        fontFamily: String = "Menlo, Monaco, 'Courier New', monospace",
        sizeMultiplier: CGFloat = 0.88,
        inlineBackground: String = "#F0F0F0",
        inlineTextColor: String? = nil,
        inlineBorderRadius: CGFloat = 4,
        inlinePadding: InlinePadding = InlinePadding(horizontal: 4, vertical: 2), // Updated default
        blockBackground: String = "#1E1E1E",
        blockTextColor: String = "#D4D4D4",
        blockBorderRadius: CGFloat = 8,
        blockPadding: CGFloat = 16,
        blockBorderAccent: Bool = false,
        blockBorderColor: String = "#007AFF"
    ) {
        self.fontFamily = fontFamily
        self.sizeMultiplier = sizeMultiplier
        self.inlineBackground = inlineBackground
        self.inlineTextColor = inlineTextColor ?? "#333333"
        self.inlineBorderRadius = inlineBorderRadius
        self.inlinePadding = inlinePadding
        self.blockBackground = blockBackground
        self.blockTextColor = blockTextColor
        self.blockBorderRadius = blockBorderRadius
        self.blockPadding = blockPadding
        self.blockBorderAccent = blockBorderAccent
        self.blockBorderColor = blockBorderColor
    }
    
    public static let `default` = CodeBlockStyle()
    public static let light = CodeBlockStyle(blockBackground: "#F5F5F5", blockTextColor: "#333333")
    
    public static let minimal = CodeBlockStyle(
        inlineBackground: "transparent",
        inlineBorderRadius: 0,
        inlinePadding: InlinePadding(horizontal: 0, vertical: 0), // Updated
        blockBackground: "#F8F8F8",
        blockTextColor: "#333333",
        blockBorderRadius: 0,
        blockPadding: 12
    )
    
    public static let github = CodeBlockStyle(
        blockBackground: "#24292E",
        blockTextColor: "#E1E4E8",
        blockBorderRadius: 6,
        blockPadding: 16,
        blockBorderAccent: true,
        blockBorderColor: "#007AFF"
    )
}
