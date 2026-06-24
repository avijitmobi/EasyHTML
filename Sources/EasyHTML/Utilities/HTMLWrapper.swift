//
//  HTMLWrapper.swift
//  EasyHTML
//
//  Created by Avijit Mondal
//

import Foundation

struct HTMLWrapper {
    let configuration: EasyHTMLConfiguration
    let observerName: String
    
    func wrap(_ html: String) -> String {
        let css = CSSGenerator(configuration: configuration).generate()
        return """
        <!DOCTYPE html>
        <html>
        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
            <style>\(css)</style>
            <script>
                function reportHeight() {
                    var height = document.documentElement.scrollHeight;
                    window.webkit.messageHandlers.\(observerName).postMessage({ 'height': height });
                }
                var observer = new MutationObserver(reportHeight);
                document.addEventListener('DOMContentLoaded', function() {
                    observer.observe(document.documentElement, { childList: true, subtree: true, attributes: true });
                    setTimeout(reportHeight, 100);
                    setTimeout(reportHeight, 500);
                    setTimeout(reportHeight, 1000);
                });
                window.addEventListener('load', reportHeight);
            </script>
        </head>
        <body>\(html)</body>
        </html>
        """
    }
    
    var injectionScript: String {
        """
        (function() {
            function reportHeight() {
                var height = document.documentElement.scrollHeight;
                window.webkit.messageHandlers.\(observerName).postMessage({ 'height': height });
            }
            var observer = new MutationObserver(reportHeight);
            observer.observe(document.documentElement, { childList: true, subtree: true });
            reportHeight(); setTimeout(reportHeight, 500); setTimeout(reportHeight, 1000);
            window.addEventListener('load', reportHeight);
        })();
        """
    }
}
