//
//  NSImage+Exts.swift
//  Pods
//
//  Created by 抓猫的鱼 on 2020/5/4.
//

import Cocoa

extension TypeWrapperProtocol where WrappedType == NSImage {
    
    
    public func image(with opacity: Float) -> NSImage {
        let size = self.wrappedValue.size;
        let newImage = NSImage.init(size: size)
        
        newImage.lockFocus()
        self.wrappedValue.draw(at: .zero, from: .zero, operation: .sourceOver, fraction: CGFloat(opacity))
        newImage.unlockFocus()
        return newImage
    }
    
}
