//
//  StringSizeTests.swift
//  SDSStringExtension
//
//  Created by Tomoaki Yagishita on 2025/11/03.
//

import XCTest

final class StringSizeTests: XCTestCase {
#if canImport(AppKit)
public typealias NSUIFont = NSFont
#elseif canImport(UIKit)
public typealias NSUIFont = UIFont
#endif

    func testSizeFromStyle() throws {
        let text = "Hello, world!"
        XCTAssertEqual(text.size(.body), CGSize(width: 75.49267578125 , height: 16))
        XCTAssertEqual(text.size(.title1), CGSize(width: 116.65587615966797, height: 25.91015625))
    }
    func testSizeFromFont() throws {
        let text = "Hello, world!"
        XCTAssertEqual(text.size(NSUIFont.systemFont(ofSize: NSUIFont.systemFontSize)), CGSize(width: 75.49267578125 , height: 16))
    }
}
