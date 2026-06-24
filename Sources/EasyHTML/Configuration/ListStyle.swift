//
//  ListStyle.swift
//  EasyHTML
//
//  Created by Avijit Mondal
//

import Foundation

/// Configuration for list (ul, ol) styling.
public struct ListStyle: Equatable {
    
    /// Left padding/indentation in pixels.
    public let indentation: CGFloat
    
    /// List style type for unordered lists: "disc", "circle", "square", "none".
    public let unorderedMarker: String
    
    /// List style type for ordered lists: "decimal", "lower-alpha", "upper-roman", etc.
    public let orderedMarker: String
    
    /// Spacing between list items in pixels.
    public let itemSpacing: CGFloat
    
    /// Color of the list markers.
    public let markerColor: String?
    
    /// Creates a new list style.
    /// - Parameters:
    ///   - indentation: Left indentation. Default is 24.
    ///   - unorderedMarker: Unordered list marker. Default is "disc".
    ///   - orderedMarker: Ordered list marker. Default is "decimal".
    ///   - itemSpacing: Item spacing. Default is 4.
    ///   - markerColor: Marker color. Default is nil (inherits text).
    public init(
        indentation: CGFloat = 24,
        unorderedMarker: String = "disc",
        orderedMarker: String = "decimal",
        itemSpacing: CGFloat = 4,
        markerColor: String? = nil
    ) {
        self.indentation = indentation
        self.unorderedMarker = unorderedMarker
        self.orderedMarker = orderedMarker
        self.itemSpacing = itemSpacing
        self.markerColor = markerColor
    }
    
    // MARK: - Presets
    
    /// Default list style.
    public static let `default` = ListStyle()
    
    /// No markers.
    public static let noMarkers = ListStyle(unorderedMarker: "none", orderedMarker: "none")
    
    /// Square bullet points.
    public static let square = ListStyle(unorderedMarker: "square")
    
    /// Alpha ordered lists (a, b, c...).
    public static let alpha = ListStyle(orderedMarker: "lower-alpha")
    
    /// Roman numeral ordered lists (I, II, III...).
    public static let roman = ListStyle(orderedMarker: "upper-roman")
    
    /// Compact list with less indentation.
    public static let compact = ListStyle(indentation: 16, itemSpacing: 2)
}
