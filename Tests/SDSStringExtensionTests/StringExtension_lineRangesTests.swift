//
//  StringExtension_lineRangesTests.swift
//  SDSStringExtension
//
//  Created by Tomoaki Yagishita on 2026/04/22.
//

import XCTest
@testable import SDSStringExtension

final class StringExtension_lineRangesTests: XCTestCase {
    let manyTexts = """
This is firstline.
This is secondline.
These lines should be one paragraph
"""

    // func basic
    func test_lineRanges_check() throws {
        let manyTexts = """
This is firstline.
This is secondline.
These lines should be one paragraph
"""
        let result = manyTexts.lineRanges()
        XCTAssertEqual(result.count, 3)
        XCTAssertEqual(manyTexts[result[0]], "This is firstline.")
        XCTAssertEqual(manyTexts[result[1]], "This is secondline.")
        XCTAssertEqual(manyTexts[result[2]], "These lines should be one paragraph")
    }

    func test_lineRanges_checkWithNSRange() throws {
        let str = """
This is firstline.
This is firstline.
"""
        let result = str.lineRanges()
        XCTAssertEqual(result.count, 2)
        XCTAssertEqual(str[result[0]], "This is firstline.")
        XCTAssertEqual(str[result[1]], "This is firstline.")
        let nsRange0 = NSRange(result[0], in: str)
        XCTAssertEqual(nsRange0.location, 0)
        XCTAssertEqual(nsRange0.length, 18)
        let nsRange1 = NSRange(result[1], in: str)
        XCTAssertEqual(nsRange1.location, 19)
        XCTAssertEqual(nsRange1.length, 18)

    }

    func test_lineRanges_checkWithNSRange_NewLineNewLine() throws {
        let str = """
This is firstline.
This is firstline.


"""
        let result = str.lineRanges()
        XCTAssertEqual(result.count, 4)
        XCTAssertEqual(str[result[0]], "This is firstline.")
        XCTAssertEqual(str[result[1]], "This is firstline.")
        let nsRange0 = NSRange(result[0], in: str)
        XCTAssertEqual(nsRange0.location, 0)
        XCTAssertEqual(nsRange0.length, 18)
        let nsRange1 = NSRange(result[1], in: str)
        XCTAssertEqual(nsRange1.location, 19)
        XCTAssertEqual(nsRange1.length, 18)

    }


//    func test_parse_onlyParagraph_shouldBeOneParagraph() throws {
//        let sut = MarkdownParser()
//        let result = sut.parse(manyTexts)
//        let child = result.
//    }

}
