@testable import SDSStringExtension
import XCTest

final class SDSStringExtensionTests: XCTestCase {
    
    func test_lineNSRanges_zeroLine() async throws {
        let testString = ""
        let ranges = testString.lineNSRanges()
        XCTAssertEqual(ranges.count, 0)
    }
    
    
    func test_lineNSRanges_emptyLine() async throws {
        let testString = """
        
        
        """
        // only one \n is contained in above, so complete empty line is not counted as line i.e. above has only 1 line
        print((testString as NSString).length)
        let ranges = testString.lineNSRanges()
        XCTAssertEqual(ranges.count, 1)
        let range = try XCTUnwrap(ranges.first)
        XCTAssertEqual(range, NSRange(location: 0, length: 1))
    }
    
    func test_lineNSRanges_oneLine() async throws {
        let testString = "Hello world"
        
        let ranges = testString.lineNSRanges()
        XCTAssertEqual(ranges.count, 1)
        let range = try XCTUnwrap(ranges.first)
        XCTAssertEqual(range, NSRange(location: 0, length: 11))
        
    }
    
    
    func test_lineNSRanges_twoLine() async throws {
        let testString = """
Hello world
Hello world
"""
        
        let ranges = testString.lineNSRanges()
        XCTAssertEqual(ranges.count, 2)
        let range1 = ranges[0]
        let range2 = ranges[1]
        XCTAssertEqual(range1, NSRange(location: 0, length: 12))
        XCTAssertEqual(range2, NSRange(location: 12, length: 11))
        
    }
    
    func test_lineNSRanges_threeLine() async throws {
        let testString = """
Hello world
Hello world


"""
        
        let ranges = testString.lineNSRanges()
        XCTAssertEqual(ranges.count, 3)
        let range1 = ranges[0]
        let range2 = ranges[1]
        let range3 = ranges[2]
        XCTAssertEqual(range1, NSRange(location: 0, length: 12))
        XCTAssertEqual(range2, NSRange(location: 12, length: 12))
        XCTAssertEqual(range3, NSRange(location: 24, length: 1))
        
    }
    



}
