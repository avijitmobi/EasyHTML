//
//  HTMLWrapper.swift
//  EasyHTML
//
//  Created by Avijit Mondal
//

import Foundation

/// Wraps HTML content with styles and height observation scripts.
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
            <style>
                \(css)
            </style>
            <script>
                // Height observation and reporting
                function reportHeight() {
                    var height = document.documentElement.scrollHeight;
                    window.webkit.messageHandlers.\(observerName).postMessage({ 'height': height });
                }
                
                // MutationObserver for dynamic content
                var observer = new MutationObserver(function(mutations) {
                    reportHeight();
                });
                
                // Start observing when DOM is ready
                document.addEventListener('DOMContentLoaded', function() {
                    observer.observe(document.documentElement, {
                        childList: true,
                        subtree: true,
                        attributes: true,
                        characterData: true
                    });
                    
                    // Initial reports with delays for async content
                    setTimeout(reportHeight, 50);
                    setTimeout(reportHeight, 150);
                    setTimeout(reportHeight, 300);
                    setTimeout(reportHeight, 600);
                    setTimeout(reportHeight, 1000);
                });
                
                // Report on all images loaded
                window.addEventListener('load', function() {
                    reportHeight();
                });
                
                // Report on image load events
                document.addEventListener('load', function(e) {
                    if (e.target.tagName === 'IMG') {
                        reportHeight();
                    }
                }, true);
            </script>
        </head>
        <body>
            \(html)
        </body>
        </html>
        """
    }
    
    /// JavaScript to inject for URL-loaded content
    var injectionScript: String {
        """
        (function() {
            function reportHeight() {
                var height = document.documentElement.scrollHeight;
                window.webkit.messageHandlers.\(observerName).postMessage({ 'height': height });
            }
            
            var observer = new MutationObserver(reportHeight);
            observer.observe(document.documentElement, { childList: true, subtree: true });
            
            reportHeight();
            setTimeout(reportHeight, 300);
            setTimeout(reportHeight, 600);
            setTimeout(reportHeight, 1000);
            
            window.addEventListener('load', reportHeight);
        })();
        """
    }
}

