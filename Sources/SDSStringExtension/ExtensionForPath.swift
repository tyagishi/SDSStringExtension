//
//  File.swift
//
//  Created by : Tomoaki Yagishita on 2024/10/14
//  © 2024  SmallDeskSoftware
//

import Foundation

extension Substring {
    var dotSuffix: Substring? {
        guard let dotIndex = self.lastIndex(of: ".") else { return nil }
        let nextIndex = self.index(after: dotIndex)
        return self[nextIndex...]
    }
}

extension String {
    var dotSuffix: Substring? {
        guard let dotIndex = self.lastIndex(of: ".") else { return nil }
        let nextIndex = self.index(after: dotIndex)
        return self[nextIndex...]
    }
}
