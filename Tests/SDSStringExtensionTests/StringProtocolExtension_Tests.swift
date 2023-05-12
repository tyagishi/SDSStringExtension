//
//  StringProtocolExtension_Tests.swift
//
//  Created by : Tomoaki Yagishita on 2023/04/28
//  © 2023  SmallDeskSoftware
//

import XCTest

final class StringProtocolExtension_Tests: XCTestCase {
    func test_StringProtocol_allRange_1Found() async throws {
        let sut = """
    nonetestnone
    """
        let results = try XCTUnwrap(sut.allRange(of: "test", range: sut.fullRange))
        XCTAssertEqual(results.count, 1)
        let result = try XCTUnwrap(results.first)
        XCTAssertEqual(sut[result], "test")
    }
    
    func test_StringProtocol_allRange_3Found() async throws {
        let sut = """
    nonetestnone
    another
    testatstart
    endoftest
    noword
    """
        let results = try XCTUnwrap(sut.allRange(of: "test", range: sut.fullRange))
        XCTAssertEqual(results.count, 3)
        for result in results {
            XCTAssertEqual(sut[result], "test")
        }
    }

    func test_withoutLastNewLine() async throws {
        let sut1 = "hello"
        XCTAssertEqual(sut1.withoutLastNewLine as? String, "hello")

        let sut2 = "hello\n"
        XCTAssertEqual(sut2.withoutLastNewLine as? Substring, "hello")
        
        let sut3 = "hello\nworld"
        XCTAssertEqual(sut3.withoutLastNewLine as? String, "hello\nworld")
    }

    func test_dropFirstLine() async throws {
        let sut1 = "hello"
        XCTAssertEqual(sut1.dropFirstLine as? String, "")

        let sut1n = "hello\n"
        XCTAssertEqual(sut1n.dropFirstLine as? Substring, "")

        let sut2 = ""
        XCTAssertEqual(sut2.dropFirstLine as? String, "")

        let sut3 = "hello\nworld"
        XCTAssertEqual(sut3.dropFirstLine as? Substring, "world")

        let sut4 = "hello\nworld\nanother"
        XCTAssertEqual(sut4.dropFirstLine as? Substring, "world\nanother")

        let sut5 = "hello\nworld\nanother\n"
        XCTAssertEqual(sut5.dropFirstLine as? Substring, "world\nanother\n")

        let sut6 = "\nhello\nworld\nanother\n"
        XCTAssertEqual(sut6.dropFirstLine as? Substring, "hello\nworld\nanother\n")
    }

    func test_dropLastLine() async throws {
        let sut1 = "hello"
        XCTAssertEqual(sut1.dropLastLine as? String, "")

        let sut1n = "hello\n"
        XCTAssertEqual(sut1n.dropLastLine as? String, "")

        let sut2 = ""
        XCTAssertEqual(sut2.dropLastLine as? String, "")

        let sut3 = "hello\nworld"
        XCTAssertEqual(sut3.dropLastLine as? Substring, "hello\n")

        let sut4 = "hello\nworld\nanother"
        XCTAssertEqual(sut4.dropLastLine as? Substring, "hello\nworld\n")

        let sut5 = "hello\nworld\nanother\n"
        XCTAssertEqual(sut5.dropLastLine as? Substring, "hello\nworld\n")

        let sut6 = "\nhello\nworld\nanother\n"
        XCTAssertEqual(sut6.dropLastLine as? Substring, "\nhello\nworld\n")
    }

    func test_dropFirstLastLine() async throws {
        let sut1 = "hello"
        XCTAssertEqual(sut1.dropFirstLine.dropLastLine as? String, "")
        XCTAssertEqual(sut1.dropLastLine.dropFirstLine as? String, "")

        let sut1n = "hello\n"
        XCTAssertEqual(sut1n.dropFirstLine.dropLastLine as? String, "")
        XCTAssertEqual(sut1n.dropLastLine.dropFirstLine as? String, "")

        let sut2 = ""
        XCTAssertEqual(sut2.dropFirstLine.dropLastLine as? String, "")
        XCTAssertEqual(sut2.dropLastLine.dropFirstLine as? String, "")

        let sut3 = "hello\nworld"
        XCTAssertEqual(sut3.dropFirstLine.dropLastLine as? String, "")
        XCTAssertEqual(sut3.dropLastLine.dropFirstLine as? Substring, "")

        let sut4 = "hello\nworld\nanother"
        XCTAssertEqual(sut4.dropFirstLine.dropLastLine as? Substring, "world\n")
        XCTAssertEqual(sut4.dropLastLine.dropFirstLine as? Substring, "world\n")

        let sut5 = "hello\nworld\nanother\n"
        XCTAssertEqual(sut5.dropFirstLine.dropLastLine as? Substring, "world\n")
        XCTAssertEqual(sut5.dropLastLine.dropFirstLine as? Substring, "world\n")

        let sut6 = "\nhello\nworld\nanother\n"
        XCTAssertEqual(sut6.dropFirstLine.dropLastLine as? Substring, "hello\nworld\n")
        XCTAssertEqual(sut6.dropLastLine.dropFirstLine as? Substring, "hello\nworld\n")
    }
    
}
