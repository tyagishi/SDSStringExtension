//
//  ExtensionForPathTests.swift
//
//  Created by : Tomoaki Yagishita on 2024/10/14
//  © 2024  SmallDeskSoftware
//

import XCTest
@testable import SDSStringExtension

final class ExtensionForPathTests: XCTestCase {

    func test_standardString() async throws {
        let string = "Hello World.txt"
        XCTAssertEqual(try XCTUnwrap(string.dotSuffix), "txt")
    }

    func test_endWithDotString() async throws {
        let string = "Hello World."
        XCTAssertEqual(try XCTUnwrap(string.dotSuffix), "")
    }

    func test_manyDotsString() async throws {
        let string = "Hello.World.txt"
        XCTAssertEqual(try XCTUnwrap(string.dotSuffix), "txt")
    }

    func test_standardSubstring() async throws {
        let string = "Hello World.txt"
        let substring = string[(string.startIndex)..<(string.index(string.startIndex, offsetBy: 14))]
        XCTAssertEqual(try XCTUnwrap(substring.dotSuffix), "tx")
    }
}
