//
//  EasyHTMLContent.swift
//  EasyHTML
//
//  Created by Avijit Mondal
//

import Foundation

public enum EasyHTMLContent: Equatable {
    case html(String)
    case url(URL)
    case urlString(String)
    
    public static func == (lhs: EasyHTMLContent, rhs: EasyHTMLContent) -> Bool {
        switch (lhs, rhs) {
        case (.html(let lhsHTML), .html(let rhsHTML)): return lhsHTML == rhsHTML
        case (.url(let lhsURL), .url(let rhsURL)): return lhsURL == rhsURL
        case (.urlString(let lhsString), .urlString(let rhsString)): return lhsString == rhsString
        default: return false
        }
    }
    
    var htmlString: String? {
        if case .html(let string) = self { return string }
        return nil
    }
    
    var url: URL? {
        if case .url(let url) = self { return url }
        if case .urlString(let string) = self { return URL(string: string) }
        return nil
    }
    
    var isRemote: Bool {
        if case .html = self { return false }
        return true
    }
}
