//
//  SDSStringExtensionTests_currentLine.swift
//
//  Created by : Tomoaki Yagishita on 2022/10/16
//  © 2022  SmallDeskSoftware
//

import XCTest

final class SDSStringExtensionTests_currentLine: XCTestCase {

    func test_currentLine() async throws {
        let testString = """
01234
56789
"""
        let currentLineRange = testString.currentLineRange(testString.startIndex)
        XCTAssertEqual(testString[currentLineRange], "01234")
    }

    func test_currentLine_nsRange() async throws {
        let testString = """
01234
56789
"""
        let currentLineRange = testString.currentLineNSRange(2)
        XCTAssertEqual(currentLineRange.location, 0)
        XCTAssertEqual(currentLineRange.length, 5)
    }

    func test_currentLine_2() async throws {
        let testString = """
01234
56789
"""
        let currentLineRange = testString.currentLineRange(testString.index(testString.startIndex, offsetBy: 7))
        XCTAssertEqual(testString[currentLineRange], "56789")
    }
    func test_currentLine_2_nsRange() async throws {
        let testString = """
01234
56789
"""
        let currentLineRange = testString.currentLineNSRange(7)
        XCTAssertEqual(currentLineRange.location, 6)
        XCTAssertEqual(currentLineRange.length, 5)
    }
}
