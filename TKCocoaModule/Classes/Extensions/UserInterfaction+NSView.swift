//
//  UserInterfaction+NSView.swift
//  Queen
//
//  Created by 聂子 on 2019/7/20.
//  Copyright © 2019 聂子. All rights reserved.
//

import Cocoa

extension NSView {

    fileprivate struct AssociatedKeys {
        static var UserInterface = "com.taokan.userinterface"
    }

    public var userInteractionEnabled: Bool  {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.UserInterface) as? Bool ?? true
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.UserInterface, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    override open func mouseDown(with theEvent: NSEvent) {
        if userInteractionEnabled {
            super.mouseDown(with: theEvent)
        }
    }

    override open func mouseUp(with theEvent: NSEvent) {
        if userInteractionEnabled {
            super.mouseUp(with: theEvent)
        }
    }
    
    @discardableResult
    override open func becomeFirstResponder() -> Bool {
        return userInteractionEnabled
    }

    override open func keyDown(with event: NSEvent) {
        if userInteractionEnabled {
            super.keyDown(with: event)
        }
    }

    override open func keyUp(with event: NSEvent) {
        if userInteractionEnabled {
            super.keyUp(with: event)
        }
    }
    override open func flagsChanged(with event: NSEvent) {
        if userInteractionEnabled {
            super.flagsChanged(with: event)
        }
    }

    
    public func animationUpdateContraints(duration: TimeInterval = 0.25, complation:(() ->Void)? = nil) {
        NSAnimationContext.runAnimationGroup({ (context) in
            context.duration = duration
            context.allowsImplicitAnimation = true
            self.needsUpdateConstraints = true
            self.updateConstraintsForSubtreeIfNeeded()
            self.layoutSubtreeIfNeeded()
        }) {
            complation?()
        }
    }
    
}

