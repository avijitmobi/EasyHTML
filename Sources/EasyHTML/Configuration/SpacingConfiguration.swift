//
//  SpacingConfiguration.swift
//  EasyHTML
//
//  Created by Avijit Mondal
//

import Foundation

public struct EdgeInsets: Equatable {
    public let top: CGFloat, bottom: CGFloat, left: CGFloat, right: CGFloat
    public init(top: CGFloat, bottom: CGFloat, left: CGFloat, right: CGFloat) {
        self.top = top; self.bottom = bottom; self.left = left; self.right = right
    }
    public static let zero = EdgeInsets(top: 0, bottom: 0, left: 0, right: 0)
    public static func uniform(_ value: CGFloat) -> EdgeInsets { EdgeInsets(top: value, bottom: value, left: value, right: value) }
}

public struct SpacingConfiguration: Equatable {
    public let padding: EdgeInsets
    public let lineHeight: CGFloat
    public let paragraphSpacing: CGFloat
    public let headingTopMargin: CGFloat
    public let headingBottomMargin: CGFloat
    
    public init(
        padding: EdgeInsets = EdgeInsets(top: 8, bottom: 8, left: 16, right: 16),
        lineHeight: CGFloat = 1.5,
        paragraphSpacing: CGFloat = 12,
        headingTopMargin: CGFloat = 16,
        headingBottomMargin: CGFloat = 8
    ) {
        self.padding = padding; self.lineHeight = lineHeight; self.paragraphSpacing = paragraphSpacing
        self.headingTopMargin = headingTopMargin; self.headingBottomMargin = headingBottomMargin
    }
    
    public static let standard = SpacingConfiguration()
    public static let none = SpacingConfiguration(padding: .zero, paragraphSpacing: 0, headingTopMargin: 0, headingBottomMargin: 0)
    public static let compact = SpacingConfiguration(padding: EdgeInsets(top: 4, bottom: 4, left: 8, right: 8), lineHeight: 1.3, paragraphSpacing: 6, headingTopMargin: 8, headingBottomMargin: 4)
}
