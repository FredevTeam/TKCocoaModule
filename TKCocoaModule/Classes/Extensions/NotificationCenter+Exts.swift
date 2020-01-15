//
//  NotificationCenter+Exts.swift
//  Pods-TKCocoaModule_Example
//
//  Created by 聂子 on 2019/10/7.
//

import Foundation


extension TypeWrapperProtocol where WrappedType == NotificationCenter {

    public static func send(_ name: Notification.Name) {
        self.WrappedType.default.post(name: name, object: nil, userInfo: nil)
    }

    public static func receive(_ name: Notification.Name, target: Any, selector:Selector, object: Any? = nil) {
        self.WrappedType.default.addObserver(target, selector: selector, name: name, object: object)
    }


    public static func reset(_ name: Notification.Name, target: Any, object: Any? = nil) {
        self.WrappedType.default.removeObserver(target, name: name, object: object)
    }
}

