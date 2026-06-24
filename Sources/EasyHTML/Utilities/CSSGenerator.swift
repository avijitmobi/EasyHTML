//
//  CSSGenerator.swift
//  EasyHTML
//
//  Created by Avijit Mondal
//

import Foundation

/// Generates CSS styles from configuration.
struct CSSGenerator {
    
    let configuration: EasyHTMLConfiguration
    
    func generate() -> String {
        """
        /* ===== Base Reset ===== */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            -webkit-tap-highlight-color: transparent;
        }
        
        html {
            -webkit-text-size-adjust: 100%;
            -webkit-text-fill-color: \(configuration.colors.text);
        }
        
        /* ===== Body & Typography ===== */
        body {
            font-family: \(configuration.font.cssFontFamily);
            font-size: \(configuration.font.size)px;
            font-weight: \(configuration.font.weight);
            font-style: \(configuration.font.style);
            color: \(configuration.colors.text);
            background-color: \(configuration.colors.background);
            line-height: \(configuration.spacing.lineHeight);
            word-wrap: break-word;
            overflow-wrap: break-word;
            -webkit-font-smoothing: antialiased;
            -moz-osx-font-smoothing: grayscale;
            text-align: \(configuration.font.textAlign);
            text-transform: \(configuration.font.textTransform);
            text-decoration: \(configuration.font.textDecoration);
            padding: \(configuration.spacing.padding.top)px \(configuration.spacing.padding.right)px \(configuration.spacing.padding.bottom)px \(configuration.spacing.padding.left)px;
            \(letterSpacingCSS)
            \(wordSpacingCSS)
        }
        
        /* ===== Links ===== */
        a {
            color: \(configuration.colors.link);
            text-decoration: \(configuration.linkStyle.decoration);
            \(configuration.linkStyle.weight.map { "font-weight: \($0);" } ?? "")
        }
        
        a:visited {
            color: \(configuration.colors.visitedLink ?? configuration.colors.link);
        }
        
        /* ===== Headings ===== */
        \(headingCSS)
        
        /* ===== Paragraphs ===== */
        p {
            margin-bottom: \(configuration.spacing.paragraphSpacing)px;
        }
        
        p:last-child {
            margin-bottom: 0;
        }
        
        /* ===== Images ===== */
        img {
            max-width: \(configuration.imageStyle.maxWidth);
            height: auto;
            display: block;
            object-fit: \(configuration.imageStyle.objectFit);
            border-radius: \(configuration.imageStyle.borderRadius)px;
            margin: \(configuration.imageStyle.verticalMargin)px 0;
            \(configuration.imageStyle.shadow ? "box-shadow: 0 2px 8px rgba(0,0,0,0.15);" : "")
        }
        
        /* ===== Lists ===== */
        ul {
            list-style-type: \(configuration.listStyle.unorderedMarker);
            padding-left: \(configuration.listStyle.indentation)px;
            margin-bottom: \(configuration.spacing.paragraphSpacing)px;
        }
        
        ol {
            list-style-type: \(configuration.listStyle.orderedMarker);
            padding-left: \(configuration.listStyle.indentation)px;
            margin-bottom: \(configuration.spacing.paragraphSpacing)px;
        }
        
        li {
            margin-bottom: \(configuration.listStyle.itemSpacing)px;
            \(configuration.listStyle.markerColor.map { "color: \($0);" } ?? "")
        }
        
        li:last-child {
            margin-bottom: 0;
        }
        
        /* ===== Code ===== */
        code {
            font-family: \(configuration.codeStyle.fontFamily);
            font-size: \(configuration.font.size * configuration.codeStyle.sizeMultiplier)px;
            background-color: \(configuration.codeStyle.inlineBackground);
            color: \(configuration.codeStyle.inlineTextColor);
            border-radius: \(configuration.codeStyle.inlineBorderRadius)px;
            padding: \(configuration.codeStyle.inlinePadding.vertical)px \(configuration.codeStyle.inlinePadding.horizontal)px;
        }
        
        pre {
            font-family: \(configuration.codeStyle.fontFamily);
            font-size: \(configuration.font.size * configuration.codeStyle.sizeMultiplier)px;
            background-color: \(configuration.codeStyle.blockBackground);
            color: \(configuration.codeStyle.blockTextColor);
            border-radius: \(configuration.codeStyle.blockBorderRadius)px;
            padding: \(configuration.codeStyle.blockPadding)px;
            overflow-x: auto;
            margin: \(configuration.spacing.paragraphSpacing)px 0;
            \(configuration.codeStyle.blockBorderAccent ? "border-left: 3px solid \(configuration.codeStyle.blockBorderColor);" : "")
        }
        
        pre code {
            background: none;
            padding: 0;
            border-radius: 0;
            color: inherit;
        }
        
        /* ===== Tables ===== */
        table {
            border-collapse: \(configuration.tableStyle.borderCollapse);
            width: 100%;
            margin: \(configuration.spacing.paragraphSpacing)px 0;
            \(configuration.tableStyle.borderRadius > 0 ? "overflow: \(configuration.tableStyle.overflow); border-radius: \(configuration.tableStyle.borderRadius)px;" : "")
        }
        
        th, td {
            border: \(configuration.tableStyle.borderWidth)px solid \(configuration.tableStyle.borderColor);
            padding: \(configuration.tableStyle.cellPadding.vertical)px \(configuration.tableStyle.cellPadding.horizontal)px;
            text-align: left;
        }
        
        th {
            background-color: \(configuration.tableStyle.headerBackground);
            color: \(configuration.tableStyle.headerTextColor);
            font-weight: \(configuration.tableStyle.headerWeight);
        }
        
        \(configuration.tableStyle.alternatingRows ? "tr:nth-child(even) { background-color: \(configuration.tableStyle.alternatingRowColor); }" : "")
        
        /* ===== Blockquotes ===== */
        blockquote {
            border-left: \(configuration.blockquoteStyle.borderWidth)px solid \(configuration.blockquoteStyle.borderColor);
            background-color: \(configuration.blockquoteStyle.backgroundColor);
            \(configuration.blockquoteStyle.textColor.map { "color: \($0);" } ?? "")
            font-style: \(configuration.blockquoteStyle.fontStyle);
            padding: \(configuration.blockquoteStyle.padding.vertical)px \(configuration.blockquoteStyle.padding.right)px \(configuration.blockquoteStyle.padding.vertical)px \(configuration.blockquoteStyle.padding.left)px;
            margin: \(configuration.spacing.paragraphSpacing)px 0;
            border-radius: \(configuration.blockquoteStyle.borderRadius)px;
        }
        
        blockquote p:last-child {
            margin-bottom: 0;
        }
        
        /* ===== Horizontal Rule ===== */
        hr {
            border: none;
            border-top: \(configuration.ruleStyle.height)px solid \(configuration.ruleStyle.color);
            margin: \(configuration.ruleStyle.margin)px 0;
            width: \(configuration.ruleStyle.width);
        }
        
        /* ===== Selection ===== */
        ::selection {
            background-color: \(configuration.selectionStyle.backgroundColor);
            \(configuration.selectionStyle.textColor.map { "color: \($0);" } ?? "")
        }
        
        ::-moz-selection {
            background-color: \(configuration.selectionStyle.backgroundColor);
            \(configuration.selectionStyle.textColor.map { "color: \($0);" } ?? "")
        }
        
        /* ===== Secondary Text ===== */
        small, .secondary {
            color: \(configuration.colors.secondaryText);
            font-size: 0.875em;
        }
        
        /* ===== Strong & Emphasis ===== */
        strong, b {
            font-weight: bold;
        }
        
        em, i {
            font-style: italic;
        }
        
        /* ===== Figure & Figcaption ===== */
        figure {
            margin: \(configuration.spacing.paragraphSpacing)px 0;
        }
        
        figcaption {
            font-size: 0.875em;
            color: \(configuration.colors.secondaryText);
            text-align: center;
            margin-top: 8px;
        }
        
        /* ===== Video & Iframe ===== */
        video, iframe {
            max-width: 100%;
            border-radius: \(configuration.imageStyle.borderRadius)px;
        }
        
        /* ===== Scrollbar (WebKit) ===== */
        ::-webkit-scrollbar {
            width: 4px;
            height: 4px;
        }
        
        ::-webkit-scrollbar-track {
            background: transparent;
        }
        
        ::-webkit-scrollbar-thumb {
            background: rgba(0,0,0,0.2);
            border-radius: 2px;
        }
        """
    }
    
    // MARK: - Private Helpers
    
    private var letterSpacingCSS: String {
        guard let spacing = configuration.font.letterSpacing else { return "" }
        return "letter-spacing: \(spacing)px;"
    }
    
    private var wordSpacingCSS: String {
        guard let spacing = configuration.font.wordSpacing else { return "" }
        return "word-spacing: \(spacing)px;"
    }
    
    private var headingCSS: String {
        let headingColor = configuration.headingStyle.useCustomColor
            ? (configuration.colors.heading ?? configuration.colors.text)
            : configuration.colors.text
        
        let baseSize = configuration.font.size
        
        var css = ""
        let tags = ["h1", "h2", "h3", "h4", "h5", "h6"]
        
        for (index, tag) in tags.enumerated() {
            let multiplier = configuration.headingStyle.sizeMultipliers[safe: index] ?? 1.0
            let size = baseSize * multiplier
            
            css += """
            \(tag) {
                font-size: \(size)px;
                font-weight: \(configuration.headingStyle.weight);
                color: \(headingColor);
                text-transform: \(configuration.headingStyle.textTransform);
                margin-top: \(configuration.spacing.headingTopMargin)px;
                margin-bottom: \(configuration.spacing.headingBottomMargin)px;
                line-height: 1.3;
                \(configuration.headingStyle.letterSpacing.map { "letter-spacing: \($0)px;" } ?? "")
            }
            
            """
        }
        
        return css
    }
}

// MARK: - Array Safe Subscript

private extension Array {
    subscript(safe index: Int) -> Element? {
        guard index >= 0, index < count else { return nil }
        return self[index]
    }
}
