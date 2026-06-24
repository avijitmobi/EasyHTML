//
//  EasyHTML.swift
//  EasyHTML
//
//  Created by Avijit Mondal
//

import SwiftUI

public struct EasyHTML: View {
    private let content: EasyHTMLContent
    private let configuration: EasyHTMLConfiguration
    
    @State private var dynamicHeight: CGFloat = 0
    @State private var isLoading: Bool = false
    @State private var error: Error?
    
    public init(html: String, configuration: EasyHTMLConfiguration = .default) {
        self.content = .html(html); self.configuration = configuration
    }
    
    public init(url: URL, configuration: EasyHTMLConfiguration = .default) {
        self.content = .url(url); self.configuration = configuration
    }
    
    public init(urlString: String, configuration: EasyHTMLConfiguration = .default) {
        self.content = .urlString(urlString); self.configuration = configuration
    }
    
    public init(content: EasyHTMLContent, configuration: EasyHTMLConfiguration = .default) {
        self.content = content; self.configuration = configuration
    }
    
    public var body: some View {
        ZStack {
            if let error = error {
                VStack(spacing: 8) {
                    Image(systemName: "exclamationmark.triangle.fill").font(.title3).foregroundColor(.orange)
                    Text("Failed to load").font(.subheadline).fontWeight(.medium)
                    Text(error.localizedDescription).font(.caption).foregroundColor(.secondary).multilineTextAlignment(.center).padding(.horizontal)
                }
                .padding().frame(maxWidth: .infinity, minHeight: 100)
            } else {
                EasyHTMLWebViewRepresentable(
                    content: content,
                    configuration: configuration,
                    dynamicHeight: $dynamicHeight,
                    isLoading: $isLoading,
                    error: $error
                )
                .frame(height: max(dynamicHeight, configuration.isScrollEnabled ? 0 : 1))
                .opacity(configuration.showsLoadingIndicator && isLoading && dynamicHeight == 0 ? 0 : 1)
                .clipped()
                
                if configuration.showsLoadingIndicator && isLoading && dynamicHeight == 0 {
                    VStack(spacing: 6) {
                        ProgressView().scaleEffect(0.8)
                        Text("Loading...").font(.caption2).foregroundColor(.secondary)
                    }
                    .frame(maxWidth: .infinity, minHeight: 40)
                }
            }
        }
        .animation(.easeInOut(duration: 0.2), value: dynamicHeight)
    }
}

extension EasyHTML {
    public func font(family: String?, size: CGFloat, weight: String = "normal") -> EasyHTML {
        var config = configuration; config.font = FontConfiguration(familyName: family, size: size, weight: weight)
        return EasyHTML(content: content, configuration: config)
    }
    public func font(_ fontStyle: FontConfiguration) -> EasyHTML {
        var config = configuration; config.font = fontStyle
        return EasyHTML(content: content, configuration: config)
    }
    public func colors(_ colorConfig: ColorConfiguration) -> EasyHTML {
        var config = configuration; config.colors = colorConfig
        return EasyHTML(content: content, configuration: config)
    }
    public func spacing(_ spacingConfig: SpacingConfiguration) -> EasyHTML {
        var config = configuration; config.spacing = spacingConfig
        return EasyHTML(content: content, configuration: config)
    }
    public func contentPadding(_ insets: EdgeInsets) -> EasyHTML {
        var config = configuration; config = config.padding(insets)
        return EasyHTML(content: content, configuration: config)
    }
    public func lineHeight(_ height: CGFloat) -> EasyHTML {
        var config = configuration; config = config.lineHeight(height)
        return EasyHTML(content: content, configuration: config)
    }
    public func scrollable(_ enabled: Bool) -> EasyHTML {
        var config = configuration; config = config.scrollable(enabled)
        return EasyHTML(content: content, configuration: config)
    }
    public func showLoader(_ show: Bool) -> EasyHTML {
        var config = configuration; config = config.showLoadingIndicator(show)
        return EasyHTML(content: content, configuration: config)
    }
    public func configure(_ config: EasyHTMLConfiguration) -> EasyHTML {
        return EasyHTML(content: content, configuration: config)
    }
}
