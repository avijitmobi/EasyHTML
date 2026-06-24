//
//  CSSGenerator.swift
//  EasyHTML
//
//  Created by Avijit Mondal
//

import Foundation

struct CSSGenerator {
    let configuration: EasyHTMLConfiguration
    let fontSize: CGFloat { configuration.font.size }
    
    func generate() -> String {
        """
        * { margin: 0; padding: 0; box-sizing: border-box; -webkit-tap-highlight-color: transparent; }
        html { -webkit-text-size-adjust: 100%; -webkit-text-fill-color: \(configuration.colors.text); }
        body {
            font-family: \(configuration.font.cssFontFamily); font-size: \(fontSize)px; font-weight: \(configuration.font.weight);
            color: \(configuration.colors.text); background-color: \(configuration.colors.background);
            line-height: \(configuration.spacing.lineHeight); word-wrap: break-word; overflow-wrap: break-word;
            -webkit-font-smoothing: antialiased; text-align: \(configuration.font.textAlign);
            text-transform: \(configuration.font.textTransform);
            padding: \(configuration.spacing.padding.top)px \(configuration.spacing.padding.right)px \(configuration.spacing.padding.bottom)px \(configuration.spacing.padding.left)px;
            \(configuration.font.letterSpacing.map { "letter-spacing: \($0)px;" } ?? "")
        }
        a { color: \(configuration.colors.link); text-decoration: \(configuration.linkStyle.decoration); }
        \(generateHeadingCSS())
        p { margin-bottom: \(configuration.spacing.paragraphSpacing)px; }
        p:last-child { margin-bottom: 0; }
        img { max-width: \(configuration.imageStyle.maxWidth); height: auto; display: block; border-radius: \(configuration.imageStyle.borderRadius)px; margin: 8px 0; }
        ul { list-style-type: \(configuration.listStyle.unorderedMarker); padding-left: \(configuration.listStyle.indentation)px; margin-bottom: \(configuration.spacing.paragraphSpacing)px; }
        ol { padding-left: \(configuration.listStyle.indentation)px; margin-bottom: \(configuration.spacing.paragraphSpacing)px; }
        li { margin-bottom: 4px; }
        code { font-family: \(configuration.codeStyle.fontFamily); font-size: \(fontSize * 0.88)px; background-color: \(configuration.codeStyle.inlineBackground); border-radius: 4px; padding: 2px 4px; }
        pre { font-family: \(configuration.codeStyle.fontFamily); font-size: \(fontSize * 0.88)px; background-color: \(configuration.codeStyle.blockBackground); color: \(configuration.codeStyle.blockTextColor); border-radius: \(configuration.codeStyle.blockBorderRadius)px; padding: 16px; overflow-x: auto; margin: \(configuration.spacing.paragraphSpacing)px 0; }
        pre code { background: none; padding: 0; color: inherit; }
        table { border-collapse: collapse; width: 100%; margin: \(configuration.spacing.paragraphSpacing)px 0; }
        th, td { border: 1px solid \(configuration.tableStyle.borderColor); padding: 8px 12px; text-align: left; }
        th { background-color: \(configuration.tableStyle.headerBackground); font-weight: bold; }
        blockquote { border-left: \(configuration.blockquoteStyle.borderWidth)px solid \(configuration.blockquoteStyle.borderColor); padding: 12px 0 12px 16px; margin: \(configuration.spacing.paragraphSpacing)px 0; }
        hr { border: none; border-top: 1px solid #E0E0E0; margin: 16px 0; }
        ::selection { background-color: \(configuration.selectionStyle.backgroundColor); }
        """
    }
    
    private func generateHeadingCSS() -> String {
        let tags = ["h1", "h2", "h3", "h4", "h5", "h6"]
        return tags.enumerated().compactMap { (index, tag) in
            let multiplier = configuration.headingStyle.sizeMultipliers[safe: index] ?? 1.0
            return """
            \(tag) { font-size: \(fontSize * multiplier)px; font-weight: \(configuration.headingStyle.weight); margin-top: \(configuration.spacing.headingTopMargin)px; margin-bottom: \(configuration.spacing.headingBottomMargin)px; line-height: 1.3; }
            """
        }.joined(separator: "\n")
    }
}

private extension Array {
    subscript(safe index: Int) -> Element? {
        guard index >= 0, index < count else { return nil }
        return self[index]
    }
}
