//
//  ColorConfiguration.swift
//  EasyHTML
//
//  Created by Avijit Mondal
//

import Foundation

public struct ColorConfiguration: Equatable {
    public let text: String
    public let secondaryText: String
    public let background: String
    public let link: String
    
    public init(
        text: String = "#000000",
        secondaryText: String = "#666666",
        background: String = "#FFFFFF",
        link: String = "#007AFF"
    ) {
        self.text = text
        self.secondaryText = secondaryText
        self.background = background
        self.link = link
    }
    
    public static let light = ColorConfiguration()
    public static let dark = ColorConfiguration(text: "#FFFFFF", secondaryText: "#AAAAAA", background: "#000000", link: "#0A84FF")
    public static let sepia = ColorConfiguration(text: "#5B4636", secondaryText: "#8B7355", background: "#F4ECD8", link: "#8B4513")
}
