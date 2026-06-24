//
//  EasyHTMLConfiguration.swift
//  EasyHTML
//
//  Created by Avijit Mondal
//

import Foundation

/// The main configuration object for EasyHTML appearance and behavior.
///
/// Use this to customize every aspect of the HTML rendering, including:
/// - Fonts, colors, and spacing
/// - Links, images, and headings
/// - Lists, code blocks, and tables
/// - Blockquotes, horizontal rules, and text selection
///
/// Example:
/// ```swift
/// let config = EasyHTMLConfiguration()
///     .font(family: "Georgia", size: 18)
///     .colors(text: "#333", background: "#FFF8E1")
/// ```
public struct EasyHTMLConfiguration: Equatable {
    
    // MARK: - Style Components
    
    /// Font configuration.
    public var font: FontConfiguration
    
    /// Color configuration.
    public var colors: ColorConfiguration
    
    /// Spacing configuration.
    public var spacing: SpacingConfiguration
    
    /// Link style.
    public var linkStyle: LinkStyle
    
    /// Image style.
    public var imageStyle: ImageStyle
    
    /// Heading style.
    public var headingStyle: HeadingStyle
    
    /// List style.
    public var listStyle: ListStyle
    
    /// Code block style.
    public var codeStyle: CodeBlockStyle
    
    /// Table style.
    public var tableStyle: TableStyle
    
    /// Blockquote style.
    public var blockquoteStyle: BlockquoteStyle
    
    /// Horizontal rule style.
    public var ruleStyle: HorizontalRuleStyle
    
    /// Text selection style.
    public var selectionStyle: SelectionStyle
    
    // MARK: - Behavior
    
    /// Whether scrolling is enabled within the web view.
    public var isScrollEnabled: Bool
    
    /// Whether to show the scroll indicator.
    public var showsScrollIndicator: Bool
    
    /// Whether the web view background is opaque.
    public var isOpaque: Bool
    
    /// Whether to show a loading indicator.
    public var showsLoadingIndicator: Bool
    
    /// Custom user agent string. Use `nil` for default.
    public var userAgent: String?
    
    /// Whether to allow JavaScript in loaded content.
    public var allowsJavaScript: Bool
    
    /// Creates a new configuration with all customizable properties.
    ///
    /// - Parameters:
    ///   - font: Font configuration. Default is system font.
    ///   - colors: Color configuration. Default is light theme.
    ///   - spacing: Spacing configuration. Default is standard.
    ///   - linkStyle: Link style. Default is no decoration.
    ///   - imageStyle: Image style. Default is full-width.
    ///   - headingStyle: Heading style. Default is bold.
    ///   - listStyle: List style. Default is disc markers.
    ///   - codeStyle: Code block style. Default is dark blocks.
    ///   - tableStyle: Table style. Default is bordered.
    ///   - blockquoteStyle: Blockquote style. Default is left border.
    ///   - ruleStyle: Horizontal rule style. Default is thin gray line.
    ///   - selectionStyle: Selection style. Default is blue.
    ///   - isScrollEnabled: Enable scrolling. Default is false.
    ///   - showsScrollIndicator: Show scroll indicator. Default is false.
    ///   - isOpaque: Opaque background. Default is false.
    ///   - showsLoadingIndicator: Show loader. Default is false.
    ///   - userAgent: Custom user agent. Default is nil.
    ///   - allowsJavaScript: Allow JavaScript. Default is true (needed for height calculation).
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
        ruleStyle: HorizontalRuleStyle = .default,
        selectionStyle: SelectionStyle = .default,
        isScrollEnabled: Bool = false,
        showsScrollIndicator: Bool = false,
        isOpaque: Bool = false,
        showsLoadingIndicator: Bool = false,
        userAgent: String? = nil,
        allowsJavaScript: Bool = true
    ) {
        self.font = font
        self.colors = colors
        self.spacing = spacing
        self.linkStyle = linkStyle
        self.imageStyle = imageStyle
        self.headingStyle = headingStyle
        self.listStyle = listStyle
        self.codeStyle = codeStyle
        self.tableStyle = tableStyle
        self.blockquoteStyle = blockquoteStyle
        self.ruleStyle = ruleStyle
        self.selectionStyle = selectionStyle
        self.isScrollEnabled = isScrollEnabled
        self.showsScrollIndicator = showsScrollIndicator
        self.isOpaque = isOpaque
        self.showsLoadingIndicator = showsLoadingIndicator
        self.userAgent = userAgent
        self.allowsJavaScript = allowsJavaScript
    }
    
    // MARK: - Presets
    
    /// Default configuration with system styling.
    public static let `default` = EasyHTMLConfiguration()
    
    /// Dark mode configuration.
    public static let darkMode = EasyHTMLConfiguration(
        colors: .dark,
        codeStyle: .default,
        tableStyle: .modern,
        ruleStyle: .subtle
    )
    
    /// Reader/Article configuration optimized for long-form reading.
    public static let reader = EasyHTMLConfiguration(
        font: .serif,
        colors: .sepia,
        spacing: .comfortable,
        codeStyle: .light,
        tableStyle: .borderless,
        blockquoteStyle: .subtle
    )
    
    /// Minimal configuration for simple content.
    public static let minimal = EasyHTMLConfiguration(
        spacing: .compact,
        linkStyle: .minimal,
        imageStyle: .default,
        codeStyle: .minimal,
        blockquoteStyle: .plain,
        ruleStyle: .subtle
    )
    
    /// Card-style configuration for embedded content.
    public static let card = EasyHTMLConfiguration(
        spacing: .compact,
        isOpaque: true,
        showsLoadingIndicator: true
    )
    
    /// GitHub-style configuration.
    public static let github = EasyHTMLConfiguration(
        font: FontConfiguration(familyName: "-apple-system, BlinkMacSystemFont, 'Segoe UI', Helvetica, Arial, sans-serif", size: 16),
        colors: ColorConfiguration(text: "#24292F", secondaryText: "#656D76", background: "#FFFFFF", link: "#0969DA"),
        codeStyle: .github,
        tableStyle: .default,
        blockquoteStyle: .subtle
    )
}

// MARK: - Fluent Builder Methods

extension EasyHTMLConfiguration {
    
    /// Set font configuration.
    public func font(_ font: FontConfiguration) -> EasyHTMLConfiguration {
        var config = self
        config.font = font
        return config
    }
    
    /// Set font with specific family and size.
    public func font(family: String? = nil, size: CGFloat, weight: String = "normal") -> EasyHTMLConfiguration {
        var config = self
        config.font = FontConfiguration(familyName: family, size: size, weight: weight)
        return config
    }
    
    /// Set color configuration.
    public func colors(_ colors: ColorConfiguration) -> EasyHTMLConfiguration {
        var config = self
        config.colors = colors
        return config
    }
    
    /// Set spacing configuration.
    public func spacing(_ spacing: SpacingConfiguration) -> EasyHTMLConfiguration {
        var config = self
        config.spacing = spacing
        return config
    }
    
    /// Set link style.
    public func linkStyle(_ style: LinkStyle) -> EasyHTMLConfiguration {
        var config = self
        config.linkStyle = style
        return config
    }
    
    /// Set image style.
    public func imageStyle(_ style: ImageStyle) -> EasyHTMLConfiguration {
        var config = self
        config.imageStyle = style
        return config
    }
    
    /// Set heading style.
    public func headingStyle(_ style: HeadingStyle) -> EasyHTMLConfiguration {
        var config = self
        config.headingStyle = style
        return config
    }
    
    /// Set list style.
    public func listStyle(_ style: ListStyle) -> EasyHTMLConfiguration {
        var config = self
        config.listStyle = style
        return config
    }
    
    /// Set code block style.
    public func codeStyle(_ style: CodeBlockStyle) -> EasyHTMLConfiguration {
        var config = self
        config.codeStyle = style
        return config
    }
    
    /// Set table style.
    public func tableStyle(_ style: TableStyle) -> EasyHTMLConfiguration {
        var config = self
        config.tableStyle = style
        return config
    }
    
    /// Set blockquote style.
    public func blockquoteStyle(_ style: BlockquoteStyle) -> EasyHTMLConfiguration {
        var config = self
        config.blockquoteStyle = style
        return config
    }
    
    /// Set horizontal rule style.
    public func ruleStyle(_ style: HorizontalRuleStyle) -> EasyHTMLConfiguration {
        var config = self
        config.ruleStyle = style
        return config
    }
    
    /// Set selection style.
    public func selectionStyle(_ style: SelectionStyle) -> EasyHTMLConfiguration {
        var config = self
        config.selectionStyle = style
        return config
    }
    
    /// Enable or disable scrolling.
    public func scrollable(_ enabled: Bool) -> EasyHTMLConfiguration {
        var config = self
        config.isScrollEnabled = enabled
        config.showsScrollIndicator = enabled
        return config
    }
    
    /// Show or hide loading indicator.
    public func showLoadingIndicator(_ show: Bool) -> EasyHTMLConfiguration {
        var config = self
        config.showsLoadingIndicator = show
        return config
    }
    
    /// Set custom user agent.
    public func userAgent(_ agent: String) -> EasyHTMLConfiguration {
        var config = self
        config.userAgent = agent
        return config
    }
    
    /// Set line height.
    public func lineHeight(_ height: CGFloat) -> EasyHTMLConfiguration {
        var config = self
        config.spacing = SpacingConfiguration(
            padding: config.spacing.padding,
            lineHeight: height,
            paragraphSpacing: config.spacing.paragraphSpacing,
            headingTopMargin: config.spacing.headingTopMargin,
            headingBottomMargin: config.spacing.headingBottomMargin,
            listItemSpacing: config.spacing.listItemSpacing
        )
        return config
    }
    
    /// Set content padding.
    public func padding(_ insets: EdgeInsets) -> EasyHTMLConfiguration {
        var config = self
        config.spacing = SpacingConfiguration(
            padding: insets,
            lineHeight: config.spacing.lineHeight,
            paragraphSpacing: config.spacing.paragraphSpacing,
            headingTopMargin: config.spacing.headingTopMargin,
            headingBottomMargin: config.spacing.headingBottomMargin,
            listItemSpacing: config.spacing.listItemSpacing
        )
        return config
    }
}
