//
//  NSImage+Exts.swift
//  Pods
//
//  Created by 抓猫的鱼 on 2020/5/4.
//

import Cocoa

extension TypeWrapperProtocol where WrappedType: NSImage {
    
    
    public func image(with opacity: Float) -> NSImage {
        let size = self.wrappedValue.size;
        let newImage = NSImage.init(size: size)
        
        newImage.lockFocus()
        self.wrappedValue.draw(at: .zero, from: .zero, operation: .sourceOver, fraction: CGFloat(opacity))
        newImage.unlockFocus()
        return newImage
    }
 
    public static func image(with color: NSColor, size: NSSize) -> NSImage {
        var size = size
        if size.equalTo(CGSize.zero) {
            size = NSSize.init(width: 1, height: 1)
        }
        let newImage = NSImage.init(size: size)
        newImage.lockFocus()
        color.drawSwatch(in: NSRect.init(x: 0, y: 0, width: size.width, height: size.height))
        newImage.unlockFocus()
        return newImage
    }
    
    public func image(with tintColor: NSColor) -> NSImage {
        if self.wrappedValue.isTemplate == false {
            return self.wrappedValue
        }
        
        guard let image = self.wrappedValue.copy() as? NSImage else {
            return self.wrappedValue
        }
        image.lockFocus()
        
        tintColor.set()
        
        let imageRect = NSRect(origin: .zero, size: image.size)
        imageRect.fill(using: .sourceIn)
        
        image.unlockFocus()
        image.isTemplate = false
        
        return image
    }
}

extension TypeWrapperProtocol where WrappedType: NSImage {
    
    /// 缩放
    /// - Parameter size: 目标大小
    /// - Returns: <#description#>
    public func zoom(to size: NSSize) -> NSImage? {
        let frame = NSRect.init(x: 0, y: 0, width: size.width, height: size.height)
        
        guard let rep = self.wrappedValue.bestRepresentation(for: frame, context: nil, hints: nil) else {
            return nil
        }
        
        let image = NSImage.init(size: size)
        
        image.lockFocus()
        defer {
            image.unlockFocus()
        }
        
        if rep.draw(in: frame) {
            return image
        }
        return nil
    }
    
    
    /// 等比缩放
    /// - Parameter factor: 缩放因子，0 ~ 1
    /// - Returns: <#description#>
    public func proportionalScaling(factor:CGFloat) -> NSImage? {
        let newSize = NSSize.init(width: self.wrappedValue.size.width * factor, height: self.wrappedValue.size.width * factor)
        return self.zoom(to: newSize)
    }
    
    public func resize(to targetSize: CGSize) -> NSImage? {
        let frame = CGRect(x: 0, y: 0, width: targetSize.width, height: targetSize.height)
        guard let representation = wrappedValue.bestRepresentation(for: frame, context: nil, hints: nil) else {
            return nil
        }
        let image = NSImage(size: targetSize, flipped: false, drawingHandler: { (_) -> Bool in
            return representation.draw(in: frame)
        })
        return image
    }
    
    
}



extension NSImage {
    public var cgImage: CGImage? {
        var rect = CGRect.init(origin: .zero, size: self.size)
        return self.cgImage(forProposedRect: &rect, context: nil, hints: nil)
    }
    public var jpgData: Data? {
        guard let tiff = tiffRepresentation, let bitmapImage = NSBitmapImageRep.init(data: tiff) else {
            return nil
        }
        return bitmapImage.representation(using: .jpeg, properties: [:])
    }
    public var pngData: Data? {
        guard let tiff = tiffRepresentation, let bitmapImage = NSBitmapImageRep.init(data: tiff) else {
            return nil
        }
        return bitmapImage.representation(using: .png, properties: [:])
    }
}

