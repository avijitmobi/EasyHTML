//
//  EasyHTML.swift
//  EasyHTML
//
//  Created by Avijit Mondal
//

import SwiftUI

/// A reusable, highly customizable HTML viewer for SwiftUI.
///
/// `EasyHTML` renders HTML content from strings or URLs with dynamic height
/// and extensive customization options.
///
/// ## Quick Start
/// ```swift
/// // Basic usage with HTML string
/// EasyHTML(html: "<h1>Hello World</h1>")
///
/// // With custom font
/// EasyHTML(html: content)
///     .font(family: "Georgia", size: 18)
///
/// // Load from URL
/// EasyHTML(url: someURL)
///     .scrollable(true)
/// ```
///
/// ## Features
/// - Dynamic height based on content
/// - HTML string or URL loading
/// - Custom fonts (user-provided or system)
/// - Full color and spacing control
/// - Styled links, images, headings, lists, code blocks, tables
/// - Dark mode and reading mode presets
/// - Optional loading indicator
/// - Error handling
///
public struct EasyHTML: View {
    
    // MARK: - Properties
    
    private let content: EasyHTMLContent
    private let configuration: EasyHTMLConfiguration
    
    @State private var dynamicHeight: CGFloat = 0
    @State private var isLoading: Bool = false
    @State private var error: Error?
    
    // MARK: - Initialization
    
    /// Initialize with an HTML string.
    ///
    /// - Parameters:
    ///   - html: The HTML string to render.
    ///   - configuration: Styling configuration. Default is `.default`.
    ///
    /// Usage:
    /// ```swift
    /// EasyHTML(html: "<p>Hello, <strong>World</strong>!</p>")
    /// ```
    public init(html: String, configuration: EasyHTMLConfiguration = .default) {
        self.content = .html(html)
        self.configuration = configuration
    }
    
    /// Initialize with a URL.
    ///
    /// - Parameters:
    ///   - url: The URL to load HTML content from.
    ///   - configuration: Styling configuration. Default is `.default`.
    ///
    /// Usage:
    /// ```swift
    /// EasyHTML(url: URL(string: "https://example.com")!)
    /// ```
    public init(url: URL, configuration: EasyHTMLConfiguration = .default) {
        self.content = .url(url)
        self.configuration = configuration
    }
    
    /// Initialize with a URL string.
    ///
    /// - Parameters:
    ///   - urlString: The URL string to load content from.
    ///   - configuration: Styling configuration. Default is `.default`.
    ///
    /// Usage:
    /// ```swift
    /// EasyHTML(urlString: "https://example.com")
    /// ```
    public init(urlString: String, configuration: EasyHTMLConfiguration = .default) {
        self.content = .urlString(urlString)
        self.configuration = configuration
    }
    
    /// Initialize with an `EasyHTMLContent` enum.
    ///
    /// Useful when content type is determined at runtime.
    ///
    /// - Parameters:
    ///   - content: The content source.
    ///   - configuration: Styling configuration. Default is `.default`.
    public init(content: EasyHTMLContent, configuration: EasyHTMLConfiguration = .default) {
        self.content = content
        self.configuration = configuration
    }
    
    // MARK: - Body
    
    public var body: some View {
        ZStack {
            if let error = error {
                errorView(error)
            } else {
                webView
                    .frame(height: calculatedHeight)
                    .opacity(shouldShowContent ? 1 : 0)
                    .clipped()
                
                if configuration.showsLoadingIndicator && isLoading && dynamicHeight == 0 {
                    loadingView
                }
            }
        }
        .animation(.easeInOut(duration: 0.2), value: dynamicHeight)
    }
    
    // MARK: - Computed Properties
    
    private var calculatedHeight: CGFloat {
        max(dynamicHeight, configuration.isScrollEnabled ? 0 : 1)
    }
    
    private var shouldShowContent: Bool {
        if configuration.showsLoadingIndicator {
            return !isLoading || dynamicHeight > 0
        }
        return true
    }
    
    // MARK: - Subviews
    
    private var webView: some View {
        EasyHTMLWebViewRepresentable(
            content: content,
            configuration: configuration,
            dynamicHeight: $dynamicHeight,
            isLoading: $isLoading,
            error: $error
        )
    }
    
    private var loadingView: some View {
        HStack(spacing: 6) {
            ProgressView()
                .scaleEffect(0.8)
                .frame(width: 20, height: 20)
            if isLoading {
                Text("Loading...")
                    .font(.caption2)
                    .foregroundColor(.secondary)
            }
        }
        .frame(maxWidth: .infinity, minHeight: 30)
    }
    
    private func errorView(_ error: Error) -> some View {
        VStack(spacing: 8) {
            Image(systemName: "exclamationmark.triangle.fill")
                .font(.title3)
                .foregroundColor(.orange)
            
            Text("Failed to load content")
                .font(.subheadline)
                .fontWeight(.medium)
            
            Text(error.localizedDescription)
                .font(.caption)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 16)
        }
        .padding(16)
        .frame(maxWidth: .infinity, minHeight: 100)
    }
}

// MARK: - Fluent View Modifiers

extension EasyHTML {
    
    /// Set the font with a specific family name and size.
    ///
    /// Pass `nil` for family to use the system font.
    ///
    /// - Parameters:
    ///   - family: Font family name, or `nil` for system font.
    ///   - size: Font size in points.
    ///   - weight: CSS font weight (e.g., "normal", "bold", "600").
    public func font(family: String?, size: CGFloat, weight: String = "normal") -> EasyHTML {
        var config = configuration
        config.font = FontConfiguration(familyName: family, size: size, weight: weight)
        return EasyHTML(content: content, configuration: config)
    }
    
    /// Apply a preset font configuration.
    public func font(_ fontStyle: FontConfiguration) -> EasyHTML {
        var config = configuration
        config.font = fontStyle
        return EasyHTML(content: content, configuration: config)
    }
    
    /// Set color configuration.
    public func colors(_ colorConfig: ColorConfiguration) -> EasyHTML {
        var config = configuration
        config.colors = colorConfig
        return EasyHTML(content: content, configuration: config)
    }
    
    /// Set spacing configuration.
    public func spacing(_ spacingConfig: SpacingConfiguration) -> EasyHTML {
        var config = configuration
        config.spacing = spacingConfig
        return EasyHTML(content: content, configuration: config)
    }
    
    /// Set content padding.
    public func contentPadding(_ insets: EdgeInsets) -> EasyHTML {
        var config = configuration
        config = config.padding(insets)
        return EasyHTML(content: content, configuration: config)
    }
    
    /// Set line height.
    public func lineHeight(_ height: CGFloat) -> EasyHTML {
        var config = configuration
        config = config.lineHeight(height)
        return EasyHTML(content: content, configuration: config)
    }
    
    /// Set link style.
    public func linkStyle(_ style: LinkStyle) -> EasyHTML {
        var config = configuration
        config.linkStyle = style
        return EasyHTML(content: content, configuration: config)
    }
    
    /// Set image style.
    public func imageStyle(_ style: ImageStyle) -> EasyHTML {
        var config = configuration
        config.imageStyle = style
        return EasyHTML(content: content, configuration: config)
    }
    
    /// Set heading style.
    public func headingStyle(_ style: HeadingStyle) -> EasyHTML {
        var config = configuration
        config.headingStyle = style
        return EasyHTML(content: content, configuration: config)
    }
    
    /// Set list style.
    public func listStyle(_ style: ListStyle) -> EasyHTML {
        var config = configuration
        config.listStyle = style
        return EasyHTML(content: content, configuration: config)
    }
    
    /// Set code block style.
    public func codeStyle(_ style: CodeBlockStyle) -> EasyHTML {
        var config = configuration
        config.codeStyle = style
        return EasyHTML(content: content, configuration: config)
    }
    
    /// Set table style.
    public func tableStyle(_ style: TableStyle) -> EasyHTML {
        var config = configuration
        config.tableStyle = style
        return EasyHTML(content: content, configuration: config)
    }
    
    /// Set blockquote style.
    public func blockquoteStyle(_ style: BlockquoteStyle) -> EasyHTML {
        var config = configuration
        config.blockquoteStyle = style
        return EasyHTML(content: content, configuration: config)
    }
    
    /// Set horizontal rule style.
    public func ruleStyle(_ style: HorizontalRuleStyle) -> EasyHTML {
        var config = configuration
        config.ruleStyle = style
        return EasyHTML(content: content, configuration: config)
    }
    
    /// Set selection style.
    public func selectionStyle(_ style: SelectionStyle) -> EasyHTML {
        var config = configuration
        config.selectionStyle = style
        return EasyHTML(content: content, configuration: config)
    }
    
    /// Enable or disable scrolling.
    ///
    /// When enabled, you should provide a fixed frame height.
    public func scrollable(_ enabled: Bool) -> EasyHTML {
        var config = configuration
        config = config.scrollable(enabled)
        return EasyHTML(content: content, configuration: config)
    }
    
    /// Show or hide the loading indicator.
    public func showLoader(_ show: Bool) -> EasyHTML {
        var config = configuration
        config = config.showLoadingIndicator(show)
        return EasyHTML(content: content, configuration: config)
    }
    
    /// Apply a complete configuration.
    public func configure(_ config: EasyHTMLConfiguration) -> EasyHTML {
        EasyHTML(content: content, configuration: config)
    }
}

