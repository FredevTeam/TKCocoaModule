//
//  NSImageView+Exts.swift
//  Pods-TKCocoaModule_Example
//
//  Created by 抓猫的鱼 on 2020/8/4.
//

import Foundation


extension NSImageView {
    public typealias ActionBlock = () -> Void
    private struct AssociatedKey {
        static var UserInteractionEnabledKey = "UserInteractionEnabled_Key"
        static var MouseActionsKey = "xxxsndfknak_mouseActionsKey"
    }
    public var isUserInteractionEnabled: Bool {
        get {
            return (objc_getAssociatedObject(self, &AssociatedKey.UserInteractionEnabledKey) as? Bool) ?? false
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKey.UserInteractionEnabledKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN)
            
        }
    }
    
    private var mouseActions:[String:[ActionBlock]] {
        get {
            return (objc_getAssociatedObject(self, &AssociatedKey.MouseActionsKey) as? [String:[ActionBlock]]) ?? [:]
         }
         set {
             objc_setAssociatedObject(self, &AssociatedKey.MouseActionsKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN)
         }
    }
}


extension NSImageView {
    open override func mouseDown(with event: NSEvent) {
        if isUserInteractionEnabled, let ac = action,let tar = target {
            NSApp.sendAction(ac, to: tar, from: self)
        }
    }
    open override func mouseEntered(with event: NSEvent) {
        if isUserInteractionEnabled {
            let values = mouseActions["\(#selector(mouseEntered(with:)))"] ?? []
            values.forEach { (block) in
                block()
            }
        }
    }
    
    // 此方法未执行
    open override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        if !isUserInteractionEnabled {
            return
        }
        let trackingArea = NSTrackingArea.init(rect: dirtyRect,
                                                 options: [.mouseEnteredAndExited,
                                                           .activeWhenFirstResponder,
                                                           .activeInKeyWindow,
                                                           .activeAlways,
                                                           .activeInActiveApp],
                                                 owner: self,
                                                 userInfo: nil)
        self.addTrackingArea(trackingArea)
    }
}

extension NSImageView {
    public func addMouseAction(mouseSelector: Selector, block: @escaping NSImageView.ActionBlock) {
        var actions = mouseActions["\(mouseSelector)"] ?? []
        actions.append(block)
        mouseActions.updateValue(actions, forKey: "\(mouseSelector)")
    }

}
