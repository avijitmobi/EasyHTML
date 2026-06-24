//
//  ImageStyle.swift
//  EasyHTML
//
//  Created by Avijit Mondal
//

import Foundation

/// Configuration for image styling within HTML.
public struct ImageStyle: Equatable {
    
    /// Maximum width as percentage (0-100) or "none" for no limit.
    public let maxWidth: String
    
    /// Border radius in pixels.
    public let borderRadius: CGFloat
    
    /// Whether to add a subtle shadow.
    public let shadow: Bool
    
    /// Object fit: "cover", "contain", "fill", "none", "scale-down".
    public let objectFit: String
    
    /// Vertical margin in pixels.
    public let verticalMargin: CGFloat
    
    /// Creates a new image style.
    /// - Parameters:
    ///   - maxWidth: Max width. Default is "100%".
    ///   - borderRadius: Border radius. Default is 0.
    ///   - shadow: Apply shadow. Default is false.
    ///   - objectFit: Object fit. Default is "cover".
    ///   - verticalMargin: Vertical margin. Default is 8.
    public init(
        maxWidth: String = "100%",
        borderRadius: CGFloat = 0,
        shadow: Bool = false,
        objectFit: String = "cover",
        verticalMargin: CGFloat = 8
    ) {
        self.maxWidth = maxWidth
        self.borderRadius = borderRadius
        self.shadow = shadow
        self.objectFit = objectFit
        self.verticalMargin = verticalMargin
    }
    
    // MARK: - Presets
    
    /// Default image style.
    public static let `default` = ImageStyle()
    
    /// Rounded corners on images.
    public static let rounded = ImageStyle(borderRadius: 8)
    
    /// Circular images.
    public static let circular = ImageStyle(borderRadius: 1000)
    
    /// Images with shadow.
    public static let withShadow = ImageStyle(borderRadius: 8, shadow: true)
    
    /// Full-width images with rounded corners.
    public static let fullWidth = ImageStyle(borderRadius: 12, verticalMargin: 12)
    
    /// No constraints.
    public static let unconstrained = ImageStyle(maxWidth: "none")
}
