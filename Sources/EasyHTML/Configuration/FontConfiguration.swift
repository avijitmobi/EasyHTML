//
//  FontConfiguration.swift
//  EasyHTML
//
//  Created by Avijit Mondal
//

import Foundation

public struct FontConfiguration: Equatable {
    public let familyName: String?
    public let size: CGFloat
    public let weight: String
    public let style: String
    public let letterSpacing: CGFloat?
    public let textTransform: String
    public let textAlign: String
    
    public init(
        familyName: String? = nil,
        size: CGFloat = 16,
        weight: String = "normal",
        style: String = "normal",
        letterSpacing: CGFloat? = nil,
        textTransform: String = "none",
        textAlign: String = "left"
    ) {
        self.familyName = familyName
        self.size = size
        self.weight = weight
        self.style = style
        self.letterSpacing = letterSpacing
        self.textTransform = textTransform
        self.textAlign = textAlign
    }
    
    public static let system = FontConfiguration()
    public static let serif = FontConfiguration(familyName: "Georgia")
    public static let monospace = FontConfiguration(familyName: "Menlo", size: 14)
    
    public static func custom(familyName: String, size: CGFloat = 16, weight: String = "normal") -> FontConfiguration {
        FontConfiguration(familyName: familyName, size: size, weight: weight)
    }
    
    var cssFontFamily: String {
        if let familyName = familyName { return "'\(familyName)'" }
        return "-apple-system, BlinkMacSystemFont, 'SF Pro Text', 'Helvetica Neue', Arial, sans-serif"
    }
}
