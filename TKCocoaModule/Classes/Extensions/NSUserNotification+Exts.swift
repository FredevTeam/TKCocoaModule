//
//  NSUserNotification+Exts.swift
//  Queen
//
//  Created by 聂子 on 2019/7/14.
//  Copyright © 2019 聂子. All rights reserved.
//

import Cocoa

extension TypeWrapperProtocol where WrappedType == NSUserNotification {
//    let notification = NSUserNotification()
//    notification.identifier = "unique-id"
//    notification.title = "Hello"
//    notification.subtitle = "How are you?"
//    notification.informativeText = "This is a test"
//    notification.soundName = NSUserNotificationDefaultSoundName
//    //        notification.contentImage = NSImage(contentsOf: NSURL(string: "https://placehold.it/300")! as URL)
//    // Manually display the notification
//
//    // 延迟10 🐱 scheduleNotification 发送通知
//    notification.deliveryDate = NSDate(timeIntervalSinceNow: 10) as Date
//    let notificationCenter = NSUserNotificationCenter.default
//    notificationCenter.scheduleNotification(notification)
//    //        notificationCenter.deliver(notification)
//    // 默认情况下
    
    public static func notification(title: String?,subTitle: String?,informativeText: String?,soundName:String = NSUserNotificationDefaultSoundName,contentImage:NSImage?,identifier: String?, deliveryRepeatInterval: DateComponents?) -> NSUserNotification {
        let notification = NSUserNotification.init()
        notification.identifier = UUID.init().uuidString
        if let id = identifier {
             notification.identifier = id
        }
       if let t = title {
            notification.title = t
        }
        if let subt = subTitle {
            notification.subtitle = subt
        }
        if let info = informativeText {
            notification.informativeText = info
        }
        notification.soundName = soundName
        if let u = contentImage {
            notification.contentImage = u
        }
        if let d = deliveryRepeatInterval {
            notification.deliveryRepeatInterval = d
        }
        return notification
    }

    public func deliveryDate(date: Date) -> Self {
        self.wrappedValue.deliveryDate = date
        return self
    }

    public func scheduleNotification() {
        NSUserNotificationCenter.default.scheduleNotification(self.wrappedValue)
    }

    public func deliver() {
         NSUserNotificationCenter.default.deliver(self.wrappedValue)
    }

    public func reply(has: Bool) -> Self {
        self.wrappedValue.hasReplyButton = has
        return self
    }

    public func responsePlaceholder(s: String) -> Self {
        self.wrappedValue.responsePlaceholder = s
        return self
    }
}
