//
//  File.swift
//
//  Created by : Tomoaki Yagishita on 2022/10/22
//  © 2022  SmallDeskSoftware
//

import Foundation

extension StringProtocol {
    public func lineRanges() -> [Range<String.Index>] {
        if self == "" { return [] }
        let lines = self.split(omittingEmptySubsequences: false, whereSeparator: \.isNewline)
        var ret: [Range<String.Index>] = []
        var nextSearchStart = self.startIndex
        for line in lines {
            if line == "" {// empty line // advance one for newline character
                let emptyLineEndIndex = self.index(nextSearchStart, offsetBy: 1)
                let emptyLineRange = Range(uncheckedBounds: (nextSearchStart, emptyLineEndIndex))
                ret.append(emptyLineRange)
                nextSearchStart = emptyLineEndIndex
            } else if let range = self.range(of: line, range: nextSearchStart..<self.endIndex) {
                ret.append(range)
                nextSearchStart = self.index(nextSearchStart, offsetBy: line.count)
            }
        }
        return ret
    }

    // using StringProtocol.range(of:...)
    public func allRange(of str: any StringProtocol, options mask: String.CompareOptions = [],
                         range searchRange: Range<String.Index>, locale: Locale? = nil) -> [Range<String.Index>]? {
        var results: [Range<String.Index>] = []
        var loopSearchRange = searchRange
        while let found = self.range(of: str, options: mask, range: loopSearchRange, locale: locale),
              !loopSearchRange.isEmpty {
            results.append(found)
            loopSearchRange = Range(uncheckedBounds: (found.upperBound, searchRange.upperBound))
        }
        if results.isEmpty { return nil }
        return results
    }

    public var withoutLastNewLine: any StringProtocol {
        if self.hasSuffix("\n") {
            return self.dropLast()
        }
        return self
    }

    public var dropFirstLine: any StringProtocol {
        if let firstNewLineIndex = self.firstIndex(of: "\n") {
            let range = self.index(after: firstNewLineIndex)..<self.endIndex
            return self[range]
        } else { // no new line
            return ""
        }
    }
    public var dropLastLine: any StringProtocol {
        if let lastNewLineIndex = self.withoutLastNewLine.lastIndex(of: "\n") {
            let range = self.startIndex..<self.index(after: lastNewLineIndex)
            return self[range]
        } else { // no new line
            return ""
        }
    }
    
    public func retrieveUntil(_ character: Character) -> Self.SubSequence? {
        guard let lastIndex = self.lastIndex(of: character) else { return nil }
        return self[self.startIndex..<lastIndex]
    }
}
