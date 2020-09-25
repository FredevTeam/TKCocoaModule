//
//  NSScrollView+Exts.swift
//  Queen
//
//  Created by 聂子 on 2019/7/9.
//  Copyright © 2019 聂子. All rights reserved.
//

import Foundation
import Cocoa


extension TypeWrapperProtocol where WrappedType: NSScrollView {
    
    public func transparentizeHeaderClipView() {

        let clips = self.wrappedValue.subviews.compactMap { $0 as? NSClipView }
        guard let headclip = clips.filter({ $0 !== self.wrappedValue.contentView }).first,
            let content = headclip.documentView
            else { return }

        let visualEffectView = NSVisualEffectView(frame: NSRect.zero)
        visualEffectView.material = NSVisualEffectView.Material.light
        visualEffectView.blendingMode = NSVisualEffectView.BlendingMode.behindWindow
        visualEffectView.state = NSVisualEffectView.State.active

        headclip.documentView = visualEffectView
        visualEffectView.addSubview(content)
    }
}

extension TypeWrapperProtocol where WrappedType: NSScrollView {

    /// Scroll to the ducument view top.
    public func scrollToTop() {
        if let documentView = self.wrappedValue.documentView {
            if documentView.isFlipped {
                documentView.scroll(.zero)
            } else {
                let maxHeight = max(wrappedValue.bounds.height, documentView.bounds.height)
                documentView.scroll(NSPoint(x: 0, y: maxHeight))
            }
        }
    }
    
    public func scrollBottom() {

    //        self.enclosingScrollView?.lineScroll = 0.0
    //        self.enclosingScrollView?.pageScroll = 0.0
    //
    //        var scrollLocation = self.enclosingScrollView?.contentView.bounds.origin.y ?? 0.0 + 10.0
    //        let  maxScroll = (self.enclosingScrollView?.documentView?.bounds.size.height ?? 0.0) - (self.enclosingScrollView?.documentVisibleRect.size.height ?? 0.0)
    //
    //        scrollLocation += maxScroll
    //
    //        if scrollLocation < 0 {
    //            scrollLocation = 0
    //        }else if (scrollLocation > maxScroll) {
    //            scrollLocation = maxScroll
    //        }
    //        guard let scrollView = self.enclosingScrollView else {
    //            return
    //        }
    //
    //        scrollView.contentView.scroll(NSPoint.init(x: 0, y: scrollLocation))
    //        scrollView.reflectScrolledClipView(scrollView.contentView)

        let scrolledToBottom = NSMaxY(self.wrappedValue.visibleRect) != NSMaxY(self.wrappedValue.bounds)
            if (scrolledToBottom) {
                self.wrappedValue.scrollToEndOfDocument(self)
            } else {
                self.wrappedValue.scroll(self.wrappedValue.visibleRect.origin)
            }

        }
}


