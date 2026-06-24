//
//  Styles.swift
//  EasyHTML
//
//  Created by Avijit Mondal
//

import Foundation

public struct LinkStyle: Equatable {
    public let decoration: String
    public init(decoration: String = "none") { self.decoration = decoration }
    public static let `default` = LinkStyle()
    public static let underlined = LinkStyle(decoration: "underline")
}

public struct ImageStyle: Equatable {
    public let maxWidth: String
    public let borderRadius: CGFloat
    public init(maxWidth: String = "100%", borderRadius: CGFloat = 0) { self.maxWidth = maxWidth; self.borderRadius = borderRadius }
    public static let `default` = ImageStyle()
    public static let rounded = ImageStyle(borderRadius: 8)
}

public struct HeadingStyle: Equatable {
    public let weight: String
    public let sizeMultipliers: [CGFloat]
    public init(weight: String = "bold", sizeMultipliers: [CGFloat]? = nil) {
        self.weight = weight
        self.sizeMultipliers = sizeMultipliers ?? [2.0, 1.6, 1.3, 1.1, 1.0, 0.9]
    }
    public static let `default` = HeadingStyle()
}

public struct ListStyle: Equatable {
    public let indentation: CGFloat
    public let unorderedMarker: String
    public init(indentation: CGFloat = 24, unorderedMarker: String = "disc") { self.indentation = indentation; self.unorderedMarker = unorderedMarker }
    public static let `default` = ListStyle()
}

public struct CodeBlockStyle: Equatable {
    public let fontFamily: String
    public let inlineBackground: String
    public let blockBackground: String
    public let blockTextColor: String
    public let blockBorderRadius: CGFloat
    public init(fontFamily: String = "Menlo, Monaco, monospace", inlineBackground: String = "#F0F0F0", blockBackground: String = "#1E1E1E", blockTextColor: String = "#D4D4D4", blockBorderRadius: CGFloat = 8) {
        self.fontFamily = fontFamily; self.inlineBackground = inlineBackground; self.blockBackground = blockBackground; self.blockTextColor = blockTextColor; self.blockBorderRadius = blockBorderRadius
    }
    public static let `default` = CodeBlockStyle()
    public static let light = CodeBlockStyle(blockBackground: "#F5F5F5", blockTextColor: "#333333")
}

public struct TableStyle: Equatable {
    public let borderColor: String
    public let headerBackground: String
    public init(borderColor: String = "#E0E0E0", headerBackground: String = "#F5F5F5") { self.borderColor = borderColor; self.headerBackground = headerBackground }
    public static let `default` = TableStyle()
}

public struct BlockquoteStyle: Equatable {
    public let borderWidth: CGFloat
    public let borderColor: String
    public init(borderWidth: CGFloat = 3, borderColor: String = "#007AFF") { self.borderWidth = borderWidth; self.borderColor = borderColor }
    public static let `default` = BlockquoteStyle()
}

public struct SelectionStyle: Equatable {
    public let backgroundColor: String
    public init(backgroundColor: String = "#007AFF") { self.backgroundColor = backgroundColor }
    public static let `default` = SelectionStyle()
}
