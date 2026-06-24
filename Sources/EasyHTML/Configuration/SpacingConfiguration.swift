//
//  SpacingConfiguration.swift
//  EasyHTML
//
//  Created by Avijit Mondal
//

import Foundation

/// Configuration for spacing and padding in the HTML view.
public struct SpacingConfiguration: Equatable {
    
    /// Content padding (top, bottom, left, right).
    public let padding: EdgeInsets
    
    /// Line height multiplier (e.g., 1.5 means 150% of font size).
    public let lineHeight: CGFloat
    
    /// Paragraph bottom margin in pixels.
    public let paragraphSpacing: CGFloat
    
    /// Heading top margin in pixels.
    public let headingTopMargin: CGFloat
    
    /// Heading bottom margin in pixels.
    public let headingBottomMargin: CGFloat
    
    /// List item spacing in pixels.
    public let listItemSpacing: CGFloat
    
    /// Creates a new spacing configuration.
    /// - Parameters:
    ///   - padding: Content edge insets. Default is (8, 8, 16, 16).
    ///   - lineHeight: Line height multiplier. Default is 1.5.
    ///   - paragraphSpacing: Paragraph spacing. Default is 12.
    ///   - headingTopMargin: Heading top margin. Default is 16.
    ///   - headingBottomMargin: Heading bottom margin. Default is 8.
    ///   - listItemSpacing: List item spacing. Default is 4.
    public init(
        padding: EdgeInsets = EdgeInsets(top: 8, bottom: 8, left: 16, right: 16),
        lineHeight: CGFloat = 1.5,
        paragraphSpacing: CGFloat = 12,
        headingTopMargin: CGFloat = 16,
        headingBottomMargin: CGFloat = 8,
        listItemSpacing: CGFloat = 4
    ) {
        self.padding = padding
        self.lineHeight = lineHeight
        self.paragraphSpacing = paragraphSpacing
        self.headingTopMargin = headingTopMargin
        self.headingBottomMargin = headingBottomMargin
        self.listItemSpacing = listItemSpacing
    }
    
    // MARK: - Presets
    
    /// Default spacing.
    public static let standard = SpacingConfiguration()
    
    /// No padding.
    public static let none = SpacingConfiguration(
        padding: .zero,
        paragraphSpacing: 0,
        headingTopMargin: 0,
        headingBottomMargin: 0
    )
    
    /// Compact spacing for tight layouts.
    public static let compact = SpacingConfiguration(
        padding: EdgeInsets(top: 4, bottom: 4, left: 8, right: 8),
        lineHeight: 1.3,
        paragraphSpacing: 6,
        headingTopMargin: 8,
        headingBottomMargin: 4
    )
    
    /// Generous spacing for comfortable reading.
    public static let comfortable = SpacingConfiguration(
        padding: EdgeInsets(top: 16, bottom: 16, left: 24, right: 24),
        lineHeight: 1.8,
        paragraphSpacing: 16,
        headingTopMargin: 24,
        headingBottomMargin: 12
    )
}

/// Edge insets for padding configuration.
public struct EdgeInsets: Equatable {
    public let top: CGFloat
    public let bottom: CGFloat
    public let left: CGFloat
    public let right: CGFloat
    
    public init(top: CGFloat, bottom: CGFloat, left: CGFloat, right: CGFloat) {
        self.top = top
        self.bottom = bottom
        self.left = left
        self.right = right
    }
    
    /// Zero insets.
    public static let zero = EdgeInsets(top: 0, bottom: 0, left: 0, right: 0)
    
    /// Uniform insets on all sides.
    public static func uniform(_ value: CGFloat) -> EdgeInsets {
        EdgeInsets(top: value, bottom: value, left: value, right: value)
    }
    
    /// Horizontal-only insets.
    public static func horizontal(_ value: CGFloat) -> EdgeInsets {
        EdgeInsets(top: 0, bottom: 0, left: value, right: value)
    }
    
    /// Vertical-only insets.
    public static func vertical(_ value: CGFloat) -> EdgeInsets {
        EdgeInsets(top: value, bottom: value, left: 0, right: 0)
    }
}
