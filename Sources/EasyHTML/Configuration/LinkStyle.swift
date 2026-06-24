//
//  LinkStyle.swift
//  EasyHTML
//
//  Created by Avijit Mondal
//

import Foundation

/// Configuration for link (anchor) styling.
public struct LinkStyle: Equatable {
    
    /// Text decoration: "none", "underline", "line-through".
    public let decoration: String
    
    /// Font weight for links. Use `nil` to inherit from body.
    public let weight: String?
    
    /// Whether to show underline on hover (CSS only, limited in WKWebView).
    public let underlineOnHover: Bool
    
    /// Creates a new link style.
    /// - Parameters:
    ///   - decoration: Text decoration. Default is "none".
    ///   - weight: Font weight. Default is nil.
    ///   - underlineOnHover: Show underline on hover. Default is true.
    public init(
        decoration: String = "none",
        weight: String? = nil,
        underlineOnHover: Bool = true
    ) {
        self.decoration = decoration
        self.weight = weight
        self.underlineOnHover = underlineOnHover
    }
    
    // MARK: - Presets
    
    /// Default link style (no decoration, underline on hover).
    public static let `default` = LinkStyle()
    
    /// Always underlined links.
    public static let underlined = LinkStyle(decoration: "underline")
    
    /// Bold links without underline.
    public static let bold = LinkStyle(weight: "bold")
    
    /// Minimal link style.
    public static let minimal = LinkStyle(underlineOnHover: false)
}
