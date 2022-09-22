//
//  String+Extension.swift
//
//  Created by : Tomoaki Yagishita on 2022/08/02
//  © 2022  SmallDeskSoftware
//

import Foundation

extension String {
    public func lineNSRanges() -> [NSRange] {
        var ret: [NSRange] = []
        var pos = NSRange(location: 0, length: 0)
        while ( pos.location < (self as NSString).length) {
            // pos の行のNSRange を取得
            let lineRange = (self as NSString).lineRange(for: pos)
            ret.append(lineRange)
            pos = NSRange(location: lineRange.location + lineRange.length, length: 0)
        }
        return ret
    }
    
    public func substring(nsRange: NSRange) -> Substring {
        guard let range = Range(nsRange, in: self) else {
            fatalError("invalid nsRange")
        }
        return self[range]
    }
}

// NSRange <-> Range
extension String {
    public func nsRange(from range: Range<String.Index>) -> NSRange {
        return NSRange(range, in: self)
    }
    public func range(from nsRange: NSRange) -> Range<String.Index>? {
        return Range(nsRange, in: self)
    }
    
    public func rangeIndex(location: Int) -> String.Index {
        return self.index(self.startIndex, offsetBy: location)
    }
    public func nsRangeLocation(from index: String.Index) -> Int {
        return self.distance(from: self.startIndex, to: index)
    }
}

// find newline
extension String {
    public func nextNewline(_ from: String.Index) -> String.Index? {
        var currentIndex = from
        while currentIndex < self.endIndex {
            if self[currentIndex].isNewline {
                return currentIndex
            }
            self.formIndex(after: &currentIndex)
        }
        return nil
    }
    public func prevNewline(_ from: String.Index) -> String.Index? {
        var currentIndex = from
        while self.startIndex <= currentIndex {
            if self[currentIndex].isNewline {
                return currentIndex
            }
            if self.startIndex == currentIndex { break }
            self.formIndex(before: &currentIndex)
        }
        return nil
    }
}
// line handling
extension String {
    public func lineRange(around location: String.Index) -> Range<String.Index> {
        let range = location..<location
        return self.lineRange(for: range)
    }
}

// index & line handling
extension String {
    public func currentLineStart(index: String.Index) -> String.Index {
        var pos = index
        while self.startIndex < pos {
            let prevPos = self.index(before: pos)
            if self[prevPos].isNewline { return pos }
            pos = prevPos
        }
        return pos
    }
    // note: pointing to after last char, and char does not mean new line
    public func currentLineEnd(index: String.Index) -> String.Index {
        guard let nextLineStartIndex = nextLineStart(index: index) else { return self.endIndex }
        return self.index(nextLineStartIndex, offsetBy: -1)
    }
    
    public func nextLineStart(location: Int) -> Int? {
        let rangeLocation = self.rangeIndex(location: location)
        guard let result = nextLineStart(index: rangeLocation) else { return nil }
        return self.nsRangeLocation(from: result)
    }

    public func prevLineStart(index currentPos: String.Index) -> String.Index? {
        // find prev newline
        guard let prevNewline = self.prevNewline(currentPos) else { return nil } // no previous line
        return self.currentLineStart(index: prevNewline)
    }

    
    public func nextLineStart(index currentPos: String.Index) -> String.Index? {
        var pastNewLine = false
        var pos = currentPos
        while pos < self.endIndex,
              pastNewLine == false {
            
            pastNewLine = self[pos].isNewline
            pos = self.index(after: pos)
        }
        guard pastNewLine else { return nil }
        return pos
    }
}
extension NSString {
    public var fullNSRange: NSRange {
        NSRange(location: 0, length: self.length)
    }
}

extension String {
    // note: return nil in case prev line does not have enough length
    public func oneLineAboveIndex(_ currentIndex: String.Index) -> String.Index? {
        // in case not enough lengthy line, return nil
        let lineStartIndex = self.currentLineStart(index: currentIndex)
        let count = self.distance(from: lineStartIndex, to: currentIndex)
        guard let prevLineStartIndex = self.prevLineStart(index: currentIndex) else { return nil } // no prev line
        let prevLineSamePosIndex = self.index(prevLineStartIndex, offsetBy: count, limitedBy: lineStartIndex)
        return prevLineSamePosIndex
    }
    public func oneLineBelowIndex(_ currentIndex: String.Index) -> String.Index? {
        // in case not enough lengthy line, return nil
        let lineStartIndex = self.currentLineStart(index: currentIndex)
        let count = self.distance(from: lineStartIndex, to: currentIndex)
        guard let nextLineStartIndex = self.nextLineStart(index: currentIndex) else { return nil } // no prev line
        let nextLineEndIndex = self.currentLineEnd(index: nextLineStartIndex)
        let nextLineSamePosIndex = self.index(nextLineStartIndex, offsetBy: count, limitedBy: nextLineEndIndex)
        return nextLineSamePosIndex
    }
}
