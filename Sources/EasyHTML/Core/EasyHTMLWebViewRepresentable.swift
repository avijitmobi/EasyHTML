//
//  EasyHTMLWebViewRepresentable.swift
//  EasyHTML
//
//  Created by Avijit Mondal
//

import SwiftUI
import WebKit

struct EasyHTMLWebViewRepresentable: UIViewRepresentable {
    let content: EasyHTMLContent
    let configuration: EasyHTMLConfiguration
    @Binding var dynamicHeight: CGFloat
    @Binding var isLoading: Bool
    @Binding var error: Error?
    
    private let heightObserverName = "EasyHTMLHeightObserver"
    
    func makeCoordinator() -> Coordinator { Coordinator(self) }
    
    func makeUIView(context: Context) -> WKWebView {
        let config = WKWebViewConfiguration()
        config.userContentController.add(context.coordinator, name: heightObserverName)
        
        let webView = WKWebView(frame: .zero, configuration: config)
        webView.navigationDelegate = context.coordinator
        webView.scrollView.isScrollEnabled = configuration.isScrollEnabled
        webView.scrollView.showsVerticalScrollIndicator = configuration.showsScrollIndicator
        webView.isOpaque = configuration.isOpaque
        webView.backgroundColor = .clear
        webView.scrollView.backgroundColor = .clear
        
        if !configuration.isScrollEnabled {
            webView.scrollView.bounces = false
            webView.scrollView.alwaysBounceVertical = false
        }
        return webView
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        guard context.coordinator.currentContent != content else { return }
        context.coordinator.currentContent = content
        
        switch content {
        case .html(let htmlString): loadHTML(htmlString, in: webView)
        case .url(let url): loadURL(url, in: webView)
        case .urlString(let urlString):
            guard let url = URL(string: urlString) else {
                DispatchQueue.main.async { error = NSError(domain: "EasyHTML", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL: \(urlString)"]) }
                return
            }
            loadURL(url, in: webView)
        }
    }
    
    private func loadHTML(_ html: String, in webView: WKWebView) {
        DispatchQueue.main.async { isLoading = true; error = nil }
        let wrappedHTML = HTMLWrapper(configuration: configuration, observerName: heightObserverName).wrap(html)
        webView.loadHTMLString(wrappedHTML, baseURL: nil)
    }
    
    private func loadURL(_ url: URL, in webView: WKWebView) {
        DispatchQueue.main.async { isLoading = true; error = nil }
        webView.load(URLRequest(url: url))
    }
    
    final class Coordinator: NSObject, WKNavigationDelegate, WKScriptMessageHandler {
        var parent: EasyHTMLWebViewRepresentable
        var currentContent: EasyHTMLContent?
        private var heightUpdateWorkItem: DispatchWorkItem?
        
        init(_ parent: EasyHTMLWebViewRepresentable) { self.parent = parent }
        
        func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
            guard message.name == parent.heightObserverName,
                  let body = message.body as? [String: Any],
                  let height = body["height"] as? CGFloat else { return }
            
            heightUpdateWorkItem?.cancel()
            heightUpdateWorkItem = DispatchWorkItem { [weak self] in
                DispatchQueue.main.async {
                    guard let self = self, abs(self.parent.dynamicHeight - height) > 1 else { return }
                    self.parent.dynamicHeight = height
                }
            }
            DispatchQueue.main.async(execute: heightUpdateWorkItem!)
        }
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            DispatchQueue.main.async { self.parent.isLoading = false }
            if parent.content.isRemote {
                let script = HTMLWrapper(configuration: parent.configuration, observerName: parent.heightObserverName).injectionScript
                webView.configuration.userContentController.addUserScript(WKUserScript(source: script, injectionTime: .atDocumentEnd, forMainFrameOnly: true))
                webView.evaluateJavaScript(script)
            }
        }
        
        func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) { handle(error) }
        func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) { handle(error) }
        
        private func handle(_ error: Error) {
            DispatchQueue.main.async {
                self.parent.isLoading = false
                if (error as NSError).code != NSURLErrorCancelled { self.parent.error = error }
            }
        }
    }
}
