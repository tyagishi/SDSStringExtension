@testable import SDSStringExtension
import XCTest

final class SDSStringExtensionTests_NewLineTests: XCTestCase {
    
    func test_nextNewline_endOfCurrentLine() async throws {
        let testString = """
01234
56789
"""
        let index1 = testString.index(testString.startIndex, offsetBy: 1)
        let retIndex = testString.index(testString.startIndex, offsetBy: 5)
        let result = try XCTUnwrap(testString.nextNewline(index1))
        XCTAssertEqual(result, retIndex)
    }
    
    func test_nextLineStart_NoNewLine() async throws {
        let testString = "01234"
        
        let index1 = testString.index(testString.startIndex, offsetBy: 1)
        let result = testString.nextNewline(index1)
        XCTAssertEqual(result, nil)
    }
    
    
    func test_prevNewline_endOfPrevLine() async throws {
        let testString = """
01234
6789A
"""
        let index6 = testString.index(testString.startIndex, offsetBy: 7)
        let retIndex = testString.index(testString.startIndex, offsetBy: 5)
        let result = try XCTUnwrap(testString.prevNewline(index6))
        XCTAssertEqual(result, retIndex)
    }
    
    func test_prevLineStart_NoNewLine() async throws {
        let testString = "01234"
        
        let index1 = testString.index(testString.startIndex, offsetBy: 1)
        let result = testString.prevNewline(index1)
        XCTAssertEqual(result, nil)
    }
    
    func test_prevLineStart_NewLineOnlyLine() async throws {
        let testString = """

2345
"""

        let index3 = testString.index(testString.startIndex, offsetBy: 3)
        let retIndex = testString.index(testString.startIndex, offsetBy: 0)
        let result = testString.prevNewline(index3)
        XCTAssertEqual(result, retIndex)
    }
}
