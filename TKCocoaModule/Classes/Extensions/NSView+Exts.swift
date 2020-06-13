//
//  NSView+Exts.swift
//  Queen
//
//  Created by 聂子 on 2019/7/6.
//  Copyright © 2019 聂子. All rights reserved.
//

import Cocoa

extension TypeWrapperProtocol where WrappedType == NSView {

    public func removeAllSubviews() {
        self.wrappedValue.subviews.forEach { (v) in
            v.removeFromSuperview()
        }
    }

    public func animationUpdate() {
        self.wrappedValue.updateConstraintsForSubtreeIfNeeded()
        self.wrappedValue.updateConstraints()
        self.wrappedValue.layoutSubtreeIfNeeded()
    }

    /// mouse in view
    ///
    /// - Returns: true / false
    public func mouseInView() -> Bool {
        if self.wrappedValue.window == nil {
            return false
        }
        if self.wrappedValue.isHidden {
            return false
        }
        var point = NSEvent.mouseLocation
        point = self.wrappedValue.window?.convertFromScreen(NSRect.init(origin: point, size: CGSize.init(width: 0, height: 0))).origin ?? CGPoint.init(x: 0, y: 0)
        point = self.wrappedValue.convert(point, from: nil)
        return NSPointInRect(point, self.wrappedValue.visibleRect)
    }

    
    /// 判断 view 是否相交
    /// - Parameter view: 目标view
    /// - Returns: 结果
    public func intersect(with view: NSView) -> Bool {
        let window = self.wrappedValue.window
        
        let selfRect = self.wrappedValue.convert(self.wrappedValue.bounds, to: window?.contentView)
        let viewRect = view.convert(view.bounds, to: window?.contentView)
        return selfRect.intersects(viewRect)
    }
    
    
}

extension NSView {
    public var backgroundColor: NSColor? {
        get {
            if let colorRef = self.layer?.backgroundColor {
                return NSColor(cgColor: colorRef)
            } else {
                return nil
            }
        }
        set {
            self.wantsLayer = true
            self.layer?.backgroundColor = newValue?.cgColor
        }
    }


    
}


extension NSView {
    // x
    public var x : CGFloat {

        get {

            return frame.origin.x
        }

        set(newVal) {

            var tmpFrame : CGRect = frame
            tmpFrame.origin.x     = newVal
            frame                 = tmpFrame
        }
    }

    // y
    public var y : CGFloat {

        get {

            return frame.origin.y
        }

        set(newVal) {

            var tmpFrame : CGRect = frame
            tmpFrame.origin.y     = newVal
            frame                 = tmpFrame
        }
    }

    // height
    public var height : CGFloat {

        get {

            return frame.size.height
        }

        set(newVal) {

            var tmpFrame : CGRect = frame
            tmpFrame.size.height  = newVal
            frame                 = tmpFrame
        }
    }

    // width
    public var width : CGFloat {

        get {

            return frame.size.width
        }

        set(newVal) {

            var tmpFrame : CGRect = frame
            tmpFrame.size.width   = newVal
            frame                 = tmpFrame
        }
    }

    // left
    public var left : CGFloat {

        get {

            return x
        }

        set(newVal) {

            x = newVal
        }
    }

    // right
    public var right : CGFloat {

        get {

            return x + width
        }

        set(newVal) {

            x = newVal - width
        }
    }

    // top
    public var top : CGFloat {

        get {

            return y
        }

        set(newVal) {

            y = newVal
        }
    }

    // bottom
    public var bottom : CGFloat {

        get {

            return y + height
        }

        set(newVal) {

            y = newVal - height
        }
    }

    public var middleX : CGFloat {

        get {

            return width / 2
        }
    }

    public var middleY : CGFloat {

        get {

            return height / 2
        }
    }

    public var middlePoint : CGPoint {

        get {

            return CGPoint(x: middleX, y: middleY)
        }
    }

    public var maxX: CGFloat {
        get {
            return frame.maxX
        }
    }

    public var maxY: CGFloat {
        get {
            return frame.maxY
        }
    }

}
