//
//  EasyHTMLContent.swift
//  EasyHTML
//
//  Created by Avijit Mondal
//

import Foundation

/// Represents the source of HTML content to be rendered.
public enum EasyHTMLContent: Equatable {
    /// Raw HTML string to render directly.
    case html(String)
    
    /// A URL pointing to HTML content to load.
    case url(URL)
    
    /// A URL string that will be converted to a URL.
    case urlString(String)
    
    // MARK: - Equatable
    
    public static func == (lhs: EasyHTMLContent, rhs: EasyHTMLContent) -> Bool {
        switch (lhs, rhs) {
        case (.html(let lhsHTML), .html(let rhsHTML)):
            return lhsHTML == rhsHTML
        case (.url(let lhsURL), .url(let rhsURL)):
            return lhsURL == rhsURL
        case (.urlString(let lhsString), .urlString(let rhsString)):
            return lhsString == rhsString
        default:
            return false
        }
    }
    
    // MARK: - Helpers
    
    /// Returns the HTML string if content is `.html` case, nil otherwise.
    var htmlString: String? {
        if case .html(let string) = self { return string }
        return nil
    }
    
    /// Returns the URL if content is `.url` case, nil otherwise.
    var url: URL? {
        if case .url(let url) = self { return url }
        if case .urlString(let string) = self { return URL(string: string) }
        return nil
    }
    
    /// Whether this content is loaded from a remote URL.
    var isRemote: Bool {
        if case .html = self { return false }
        return true
    }
}
