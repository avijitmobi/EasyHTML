//
//  EasyHTMLWebViewRepresentable.swift
//  EasyHTML
//
//  Created by Avijit Mondal
//

import SwiftUI
import WebKit
import UIKit

/// Internal UIViewRepresentable for WKWebView.
struct EasyHTMLWebViewRepresentable: UIViewRepresentable {
    
    let content: EasyHTMLContent
    let configuration: EasyHTMLConfiguration
    
    @Binding var dynamicHeight: CGFloat
    @Binding var isLoading: Bool
    @Binding var error: Error?
    
    private let heightObserverName = "EasyHTMLHeightObserver"
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> WKWebView {
        let webViewConfig = WKWebViewConfiguration()
        
        // Add message handler for height updates
        webViewConfig.userContentController.add(
            context.coordinator,
            name: heightObserverName
        )
        
        // Configure JavaScript
        if !configuration.allowsJavaScript {
            // Note: Disabling JS will break height calculation
            // This is documented in the configuration
        }
        
        // Create WebView
        let webView = WKWebView(frame: .zero, configuration: webViewConfig)
        webView.navigationDelegate = context.coordinator
        webView.scrollView.delegate = context.coordinator
        
        // Configure appearance
        webView.scrollView.isScrollEnabled = configuration.isScrollEnabled
        webView.scrollView.showsVerticalScrollIndicator = configuration.showsScrollIndicator
        webView.scrollView.showsHorizontalScrollIndicator = false
        webView.isOpaque = configuration.isOpaque
        webView.backgroundColor = .clear
        webView.scrollView.backgroundColor = .clear
        
        // Disable bounce when not scrollable
        if !configuration.isScrollEnabled {
            webView.scrollView.bounces = false
            webView.scrollView.alwaysBounceVertical = false
        }
        
        // Set custom user agent if provided
        if let userAgent = configuration.userAgent {
            webView.customUserAgent = userAgent
        }
        
        return webView
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        // Prevent re-loading while already loading
        guard context.coordinator.currentContent != content else { return }
        context.coordinator.currentContent = content
        
        switch content {
        case .html(let htmlString):
            loadHTML(htmlString, in: webView)
        case .url(let url):
            loadURL(url, in: webView)
        case .urlString(let urlString):
            guard let url = URL(string: urlString) else {
                DispatchQueue.main.async {
                    error = EasyHTMLError.invalidURL(urlString)
                }
                return
            }
            loadURL(url, in: webView)
        }
    }
    
    private func loadHTML(_ html: String, in webView: WKWebView) {
        DispatchQueue.main.async {
            isLoading = true
            error = nil
        }
        
        let wrappedHTML = HTMLWrapper(
            configuration: configuration,
            observerName: heightObserverName
        ).wrap(html)
        
        webView.loadHTMLString(wrappedHTML, baseURL: nil)
    }
    
    private func loadURL(_ url: URL, in webView: WKWebView) {
        DispatchQueue.main.async {
            isLoading = true
            error = nil
        }
        
        var request = URLRequest(url: url)
        request.cachePolicy = .returnCacheDataElseLoad
        
        webView.load(request)
    }
    
    // MARK: - Coordinator
    
    final class Coordinator: NSObject, WKNavigationDelegate, WKScriptMessageHandler, UIScrollViewDelegate {
        
        var parent: EasyHTMLWebViewRepresentable
        var currentContent: EasyHTMLContent?
        private var heightUpdateWorkItem: DispatchWorkItem?
        
        init(_ parent: EasyHTMLWebViewRepresentable) {
            self.parent = parent
        }
        
        // MARK: - WKScriptMessageHandler
        
        func userContentController(
            _ userContentController: WKUserContentController,
            didReceive message: WKScriptMessage
        ) {
            guard message.name == parent.heightObserverName,
                  let body = message.body as? [String: Any],
                  let height = body["height"] as? CGFloat else {
                return
            }
            
            // Debounce height updates
            heightUpdateWorkItem?.cancel()
            heightUpdateWorkItem = DispatchWorkItem { [weak self] in
                DispatchQueue.main.async {
                    guard let self = self else { return }
                    if abs(self.parent.dynamicHeight - height) > 1 {
                        self.parent.dynamicHeight = height
                    }
                }
            }
            DispatchQueue.main.async(execute: heightUpdateWorkItem!)
        }
        
        // MARK: - WKNavigationDelegate
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            DispatchQueue.main.async {
                self.parent.isLoading = false
            }
            
            // Inject height script for URL-loaded content
            if parent.content.isRemote {
                injectHeightScript(webView)
            }
        }
        
        func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
            handleLoadError(error)
        }
        
        func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
            handleLoadError(error)
        }
        
        private func handleLoadError(_ error: Error) {
            DispatchQueue.main.async {
                self.parent.isLoading = false
                // Only set error for actual failures, not cancellations
                let nsError = error as NSError
                if nsError.code != NSURLErrorCancelled {
                    self.parent.error = error
                }
            }
        }
        
        // MARK: - UIScrollViewDelegate
        
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            // No-op, but keeps reference
        }
        
        // MARK: - Private
        
        private func injectHeightScript(_ webView: WKWebView) {
            let script = HTMLWrapper(
                configuration: parent.configuration,
                observerName: parent.heightObserverName
            ).injectionScript
            
            let userScript = WKUserScript(
                source: script,
                injectionTime: .atDocumentEnd,
                forMainFrameOnly: true
            )
            
            webView.configuration.userContentController.addUserScript(userScript)
            webView.evaluateJavaScript(script)
        }
    }
}

// MARK: - Errors

enum EasyHTMLError: LocalizedError {
    case invalidURL(String)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL(let string):
            return "Invalid URL: \(string)"
        }
    }
}

