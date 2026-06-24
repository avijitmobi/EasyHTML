//
//  EasyHTMLTests.swift
//  EasyHTMLTests
//
//  Created by Avijit Mondal
//

import XCTest
import SwiftUI
@testable import EasyHTML

final class EasyHTMLTests: XCTestCase {
    
    // MARK: - FontConfiguration Tests
    
    func testFontConfigurationDefaultUsesSystemFont() {
        let font = FontConfiguration.system
        XCTAssertNil(font.familyName, "Default font should have nil family (system)")
        XCTAssertEqual(font.size, 16)
        XCTAssertEqual(font.weight, "normal")
    }
    
    func testFontConfigurationCustomFamily() {
        let font = FontConfiguration(familyName: "Georgia", size: 18)
        XCTAssertEqual(font.familyName, "Georgia")
        XCTAssertEqual(font.size, 18)
    }
    
    func testFontConfigurationCSSFontFamily() {
        let systemFont = FontConfiguration.system
        XCTAssertTrue(systemFont.cssFontFamily.contains("-apple-system"))
        
        let customFont = FontConfiguration(familyName: "Georgia")
        XCTAssertEqual(customFont.cssFontFamily, "'Georgia'")
    }
    
    // MARK: - ColorConfiguration Tests
    
    func testColorConfigurationLightPreset() {
        let colors = ColorConfiguration.light
        XCTAssertEqual(colors.text, "#000000")
        XCTAssertEqual(colors.background, "#FFFFFF")
    }
    
    func testColorConfigurationDarkPreset() {
        let colors = ColorConfiguration.dark
        XCTAssertEqual(colors.text, "#FFFFFF")
        XCTAssertEqual(colors.background, "#000000")
    }
    
    // MARK: - SpacingConfiguration Tests
    
    func testSpacingConfigurationEdgeInsets() {
        let insets = EdgeInsets(top: 10, bottom: 20, left: 30, right: 40)
        XCTAssertEqual(insets.top, 10)
        XCTAssertEqual(insets.bottom, 20)
        XCTAssertEqual(insets.left, 30)
        XCTAssertEqual(insets.right, 40)
    }
    
    func testSpacingConfigurationUniform() {
        let insets = EdgeInsets.uniform(16)
        XCTAssertEqual(insets.top, 16)
        XCTAssertEqual(insets.bottom, 16)
        XCTAssertEqual(insets.left, 16)
        XCTAssertEqual(insets.right, 16)
    }
    
    // MARK: - EasyHTMLContent Tests
    
    func testEasyHTMLContentHTML() {
        let content: EasyHTMLContent = .html("<p>Test</p>")
        XCTAssertEqual(content.htmlString, "<p>Test</p>")
        XCTAssertNil(content.url)
        XCTAssertFalse(content.isRemote)
    }
    
    func testEasyHTMLContentURL() {
        let url = URL(string: "https://example.com")!
        let content: EasyHTMLContent = .url(url)
        XCTAssertNil(content.htmlString)
        XCTAssertEqual(content.url, url)
        XCTAssertTrue(content.isRemote)
    }
    
    func testEasyHTMLContentURLString() {
        let content: EasyHTMLContent = .urlString("https://example.com")
        XCTAssertNil(content.htmlString)
        XCTAssertNotNil(content.url)
        XCTAssertTrue(content.isRemote)
    }
    
    func testEasyHTMLContentEquality() {
        let content1: EasyHTMLContent = .html("<p>Test</p>")
        let content2: EasyHTMLContent = .html("<p>Test</p>")
        let content3: EasyHTMLContent = .html("<p>Different</p>")
        
        XCTAssertEqual(content1, content2)
        XCTAssertNotEqual(content1, content3)
    }
    
    // MARK: - EasyHTMLConfiguration Tests
    
    func testConfigurationDefaultPreset() {
        let config = EasyHTMLConfiguration.default
        XCTAssertEqual(config.font, .system)
        XCTAssertEqual(config.colors, .light)
        XCTAssertEqual(config.spacing, .standard)
        XCTAssertFalse(config.showsLoadingIndicator)
        XCTAssertFalse(config.isScrollEnabled)
    }
    
    func testConfigurationDarkModePreset() {
        let config = EasyHTMLConfiguration.darkMode
        XCTAssertEqual(config.colors, .dark)
    }
    
    func testConfigurationFluentAPI() {
        let config = EasyHTMLConfiguration.default
            .font(family: "Georgia", size: 20)
            .colors(.dark)
            .showLoadingIndicator(true)
            .scrollable(true)
        
        XCTAssertEqual(config.font.familyName, "Georgia")
        XCTAssertEqual(config.font.size, 20)
        XCTAssertEqual(config.colors, .dark)
        XCTAssertTrue(config.showsLoadingIndicator)
        XCTAssertTrue(config.isScrollEnabled)
    }
    
    func testConfigurationChainingPreservesOtherValues() {
        let config = EasyHTMLConfiguration.default
            .font(family: "Georgia", size: 20)
        
        // Other values should remain default
        XCTAssertEqual(config.colors, .light)
        XCTAssertEqual(config.spacing, .standard)
        XCTAssertEqual(config.linkStyle, .default)
    }
    
    // MARK: - String+Color Tests
    
    func testHexToColor6Digit() {
        let color = "#FF0000".toColor()
        // Can't easily compare Color, but should not crash
        XCTAssertNotNil(color)
    }
    
    func testHexToColor8Digit() {
        let color = "#FF000080".toColor()
        XCTAssertNotNil(color)
    }
    
    func testHexToColor3Digit() {
        let color = "#F00".toColor()
        XCTAssertNotNil(color)
    }
    
    func testHexToColorNoHash() {
        let color = "FF0000".toColor()
        XCTAssertNotNil(color)
    }
    
    // MARK: - CSSGenerator Tests (Integration)
    
    func testCSSGeneratorContainsFontFamily() {
        let config = EasyHTMLConfiguration()
            .font(family: "Georgia", size: 18)
        
        let css = CSSGenerator(configuration: config).generate()
        XCTAssertTrue(css.contains("Georgia"))
        XCTAssertTrue(css.contains("18px"))
    }
    
    func testCSSGeneratorContainsColors() {
        let config = EasyHTMLConfiguration()
            .colors(.dark)
        
        let css = CSSGenerator(configuration: config).generate()
        XCTAssertTrue(css.contains("#FFFFFF"))
        XCTAssertTrue(css.contains("#000000"))
    }
    
    func testCSSGeneratorSystemFontFallback() {
        let config = EasyHTMLConfiguration.default
        let css = CSSGenerator(configuration: config).generate()
        XCTAssertTrue(css.contains("-apple-system"))
    }
}

// MARK: - Mock for Preview Testing

#if DEBUG
struct EasyHTMLPreviewTests: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                EasyHTML(html: "<h1>Test</h1><p>Content</p>")
                
                EasyHTML(html: "<p>Custom font</p>")
                    .font(family: "Georgia", size: 18)
                
                EasyHTML(html: "<p>Dark mode</p>", configuration: .darkMode)
                
                EasyHTML(html: "<p>Loading test</p>")
                    .showLoader(true)
            }
            .padding()
        }
    }
}
#endif


