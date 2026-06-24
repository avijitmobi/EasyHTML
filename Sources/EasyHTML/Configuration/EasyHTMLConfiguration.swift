//
//  EasyHTMLConfiguration.swift
//  EasyHTML
//
//  Created by Avijit Mondal
//

import Foundation

public struct EasyHTMLConfiguration: Equatable {
    public var font: FontConfiguration
    public var colors: ColorConfiguration
    public var spacing: SpacingConfiguration
    public var linkStyle: LinkStyle
    public var imageStyle: ImageStyle
    public var headingStyle: HeadingStyle
    public var listStyle: ListStyle
    public var codeStyle: CodeBlockStyle
    public var tableStyle: TableStyle
    public var blockquoteStyle: BlockquoteStyle
    public var selectionStyle: SelectionStyle
    public var isScrollEnabled: Bool
    public var showsScrollIndicator: Bool
    public var isOpaque: Bool
    public var showsLoadingIndicator: Bool
    
    public init(
        font: FontConfiguration = .system,
        colors: ColorConfiguration = .light,
        spacing: SpacingConfiguration = .standard,
        linkStyle: LinkStyle = .default,
        imageStyle: ImageStyle = .default,
        headingStyle: HeadingStyle = .default,
        listStyle: ListStyle = .default,
        codeStyle: CodeBlockStyle = .default,
        tableStyle: TableStyle = .default,
        blockquoteStyle: BlockquoteStyle = .default,
        selectionStyle: SelectionStyle = .default,
        isScrollEnabled: Bool = false,
        showsScrollIndicator: Bool = false,
        isOpaque: Bool = false,
        showsLoadingIndicator: Bool = false
    ) {
        self.font = font; self.colors = colors; self.spacing = spacing
        self.linkStyle = linkStyle; self.imageStyle = imageStyle; self.headingStyle = headingStyle
        self.listStyle = listStyle; self.codeStyle = codeStyle; self.tableStyle = tableStyle
        self.blockquoteStyle = blockquoteStyle; self.selectionStyle = selectionStyle
        self.isScrollEnabled = isScrollEnabled; self.showsScrollIndicator = showsScrollIndicator
        self.isOpaque = isOpaque; self.showsLoadingIndicator = showsLoadingIndicator
    }
    
    public static let `default` = EasyHTMLConfiguration()
    public static let darkMode = EasyHTMLConfiguration(colors: .dark)
    public static let reader = EasyHTMLConfiguration(font: .serif, colors: .sepia, codeStyle: .light)
}

extension EasyHTMLConfiguration {
    public func font(_ font: FontConfiguration) -> EasyHTMLConfiguration { var c = self; c.font = font; return c }
    public func font(family: String?, size: CGFloat, weight: String = "normal") -> EasyHTMLConfiguration { var c = self; c.font = FontConfiguration(familyName: family, size: size, weight: weight); return c }
    public func colors(_ colors: ColorConfiguration) -> EasyHTMLConfiguration { var c = self; c.colors = colors; return c }
    public func spacing(_ spacing: SpacingConfiguration) -> EasyHTMLConfiguration { var c = self; c.spacing = spacing; return c }
    public func padding(_ insets: EdgeInsets) -> EasyHTMLConfiguration { var c = self; c.spacing = SpacingConfiguration(padding: insets, lineHeight: c.spacing.lineHeight, paragraphSpacing: c.spacing.paragraphSpacing, headingTopMargin: c.spacing.headingTopMargin, headingBottomMargin: c.spacing.headingBottomMargin); return c }
    public func lineHeight(_ height: CGFloat) -> EasyHTMLConfiguration { var c = self; c.spacing = SpacingConfiguration(padding: c.spacing.padding, lineHeight: height, paragraphSpacing: c.spacing.paragraphSpacing, headingTopMargin: c.spacing.headingTopMargin, headingBottomMargin: c.spacing.headingBottomMargin); return c }
    public func scrollable(_ enabled: Bool) -> EasyHTMLConfiguration { var c = self; c.isScrollEnabled = enabled; c.showsScrollIndicator = enabled; return c }
    public func showLoadingIndicator(_ show: Bool) -> EasyHTMLConfiguration { var c = self; c.showsLoadingIndicator = show; return c }
}
