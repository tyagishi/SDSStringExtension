//
//  File.swift
//
//  Created by : Tomoaki Yagishita on 2022/10/22
//  © 2022  SmallDeskSoftware
//

import Foundation

extension StringProtocol {
    func lineRanges() -> [Range<String.Index>] {
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
}
