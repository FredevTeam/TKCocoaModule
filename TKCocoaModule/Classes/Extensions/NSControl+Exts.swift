//
//  NSControl+Exts.swift
//  TKCocoaModule
//
//  Created by 抓猫的鱼 on 2020/8/4.
//

import Foundation

extension NSControl {
    public func addTarget(_ target: AnyObject?, action: Selector) {
        self.action = action
        self.target = target
    }
}
