//
//  NSFont+Exts.swift
//  TKCocoaModule
//
//  Created by 抓猫的鱼 on 2020/7/7.
//

import Cocoa

extension TypeWrapperProtocol where WrappedType == NSFont {
    public var lineHeight: CGFloat {
        return CGFloat(ceilf(Float(self.wrappedValue.ascender + abs(self.wrappedValue.descender) + self.wrappedValue.leading)))
    }
}
