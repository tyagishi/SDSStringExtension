//
//  File.swift
//
//  Created by : Tomoaki Yagishita on 2022/10/22
//  © 2022  SmallDeskSoftware
//

import Foundation

extension NSString {
    public var fullNSRange: NSRange {
        return NSRange(location: 0, length: (self as NSString).length)
    }
}

