//
//  NSViewController+Exts.swift
//  TKCocoaModule
//
//  Created by 抓猫的鱼 on 2020/6/14.
//

import Cocoa


extension TypeWrapperProtocol where WrappedType: NSViewController {
    
    
    public func animationUpdateContraints(duration: TimeInterval = 0.25, complation:(() ->Void)? = nil) {
        NSAnimationContext.runAnimationGroup({ (context) in
            context.duration = duration
            context.allowsImplicitAnimation = true
            self.wrappedValue.view.needsUpdateConstraints = true
            self.wrappedValue.view.updateConstraintsForSubtreeIfNeeded()
            self.wrappedValue.view.layoutSubtreeIfNeeded()
        }) {
            complation?()
        } 
    }
    
    
    var document: NSDocument? {
        if let doc = NSDocumentController.shared.currentDocument {
            return doc
        }else {
            return self.wrappedValue.view.window?.windowController?.document as? NSDocument
        }
    }

}
