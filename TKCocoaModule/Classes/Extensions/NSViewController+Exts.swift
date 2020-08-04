//
//  NSViewController+Exts.swift
//  TKCocoaModule
//
//  Created by 抓猫的鱼 on 2020/6/14.
//

import Cocoa





extension NSViewController {
    
    
    public func animationUpdateContraints(duration: TimeInterval = 0.25, complation:(() ->Void)? = nil) {
        NSAnimationContext.runAnimationGroup({ (context) in
            context.duration = duration
            context.allowsImplicitAnimation = true
            self.view.needsUpdateConstraints = true
            self.view.updateConstraintsForSubtreeIfNeeded()
            self.view.layoutSubtreeIfNeeded()
        }) {
            complation?()
        } 
    }
}
