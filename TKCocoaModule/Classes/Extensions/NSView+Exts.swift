//
//  NSView+Exts.swift
//  Queen
//
//  Created by 聂子 on 2019/7/6.
//  Copyright © 2019 聂子. All rights reserved.
//

import Cocoa

extension TypeWrapperProtocol where WrappedType == NSView {
    public var backgroundColor: NSColor? {
        get {
            if let colorRef = self.wrappedValue.layer?.backgroundColor {
                return NSColor(cgColor: colorRef)
            } else {
                return nil
            }
        }
        set {
            self.wrappedValue.wantsLayer = true
            self.wrappedValue.layer?.backgroundColor = newValue?.cgColor
        }
    }


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

}

extension NSView {
    // x
    var x : CGFloat {

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
    var y : CGFloat {

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
    var height : CGFloat {

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
    var width : CGFloat {

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
    var left : CGFloat {

        get {

            return x
        }

        set(newVal) {

            x = newVal
        }
    }

    // right
    var right : CGFloat {

        get {

            return x + width
        }

        set(newVal) {

            x = newVal - width
        }
    }

    // top
    var top : CGFloat {

        get {

            return y
        }

        set(newVal) {

            y = newVal
        }
    }

    // bottom
    var bottom : CGFloat {

        get {

            return y + height
        }

        set(newVal) {

            y = newVal - height
        }
    }

    var middleX : CGFloat {

        get {

            return width / 2
        }
    }

    var middleY : CGFloat {

        get {

            return height / 2
        }
    }

    var middlePoint : CGPoint {

        get {

            return CGPoint(x: middleX, y: middleY)
        }
    }

    var maxX: CGFloat {
        get {
            return frame.maxX
        }
    }

    var maxY: CGFloat {
        get {
            return frame.maxY
        }
    }

}
