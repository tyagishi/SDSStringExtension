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
}
