//
//  ColorConfiguration.swift
//  EasyHTML
//
//  Created by Avijit Mondal
//

import Foundation

/// Configuration for all color-related settings in the HTML view.
public struct ColorConfiguration: Equatable {
    
    /// Primary text color (hex string, e.g., "#000000").
    public let text: String
    
    /// Secondary/muted text color.
    public let secondaryText: String
    
    /// Background color.
    public let background: String
    
    /// Heading color. Use `nil` to inherit from text color.
    public let heading: String?
    
    /// Link color.
    public let link: String
    
    /// Visited link color. Use `nil` to inherit from link color.
    public let visitedLink: String?
    
    /// Creates a new color configuration.
    /// - Parameters:
    ///   - text: Primary text color. Default is "#000000".
    ///   - secondaryText: Secondary text color. Default is "#666666".
    ///   - background: Background color. Default is "#FFFFFF".
    ///   - heading: Heading color. Default is nil (inherits text).
    ///   - link: Link color. Default is "#007AFF".
    ///   - visitedLink: Visited link color. Default is nil (inherits link).
    public init(
        text: String = "#000000",
        secondaryText: String = "#666666",
        background: String = "#FFFFFF",
        heading: String? = nil,
        link: String = "#007AFF",
        visitedLink: String? = nil
    ) {
        self.text = text
        self.secondaryText = secondaryText
        self.background = background
        self.heading = heading
        self.link = link
        self.visitedLink = visitedLink
    }
    
    // MARK: - Presets
    
    /// Light theme colors.
    public static let light = ColorConfiguration()
    
    /// Dark theme colors.
    public static let dark = ColorConfiguration(
        text: "#FFFFFF",
        secondaryText: "#AAAAAA",
        background: "#000000",
        link: "#0A84FF"
    )
    
    /// Warm sepia-toned colors (like reading apps).
    public static let sepia = ColorConfiguration(
        text: "#5B4636",
        secondaryText: "#8B7355",
        background: "#F4ECD8",
        link: "#8B4513"
    )
    
    /// High contrast for accessibility.
    public static let highContrast = ColorConfiguration(
        text: "#000000",
        secondaryText: "#000000",
        background: "#FFFFFF",
        link: "#0000EE"
    )
    
    /// Creates a custom color configuration.
    /// - Parameters:
    ///   - text: Text color hex.
    ///   - background: Background color hex.
    ///   - link: Link color hex.
    public static func custom(
        text: String,
        background: String,
        link: String = "#007AFF"
    ) -> ColorConfiguration {
        ColorConfiguration(text: text, background: background, link: link)
    }
}

