//
//  EasyHTMLTests.swift
//  EasyHTMLTests
//
//  Created by Avijit Mondal
//

import XCTest
@testable import EasyHTML

final class EasyHTMLTests: XCTestCase {
    func testDefaultFontIsSystem() {
        let font = FontConfiguration.system
        XCTAssertNil(font.familyName)
        XCTAssertTrue(font.cssFontFamily.contains("-apple-system"))
    }
    
    func testCustomFontCSS() {
        let font = FontConfiguration.custom(familyName: "Georgia", size: 18)
        XCTAssertEqual(font.cssFontFamily, "'Georgia'")
    }
    
    func testContentEquality() {
        let c1: EasyHTMLContent = .html("<p>A</p>")
        let c2: EasyHTMLContent = .html("<p>A</p>")
        XCTAssertEqual(c1, c2)
    }
    
    func testHexToColor() {
        let color = "#FF0000".toColor()
        XCTAssertNotNil(color)
    }
}
