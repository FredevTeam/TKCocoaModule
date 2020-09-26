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



@objc
protocol ContainerViewDelegate:class {
    func process(_ resouse:[String])
    @objc optional func draggingEnded(_ sender: NSDraggingInfo)
    @objc optional func draggingExited(_ sender: NSDraggingInfo?)
}
//
//extension ContainerView {
//    // 拖拽结束
//    override func draggingEnded(_ sender: NSDraggingInfo) {
//        debugPrint("\(#function )")
//        self.delegate?.draggingEnded?(sender)
//    }
//    // 拖拽退出
//    override func draggingExited(_ sender: NSDraggingInfo?) {
//        debugPrint("\(#function )")
//        self.delegate?.draggingExited?(sender)
//    }
//
//    /**
//    第二步：
//    当拖动数据进入 view 时会触发这个函数
//    可以在这个函数中片段数据时什么类型， 来确定要显示什么样的图标。
//    比如接受到的数据是我们想要的NSFilenamesPboardType文件类型，我们就可以在鼠标的下方显示一个“＋”号，当然我们需要返回这个类型NSDragOperationCopy。如果接受到的文件不是我们想要的数据格式，可以返回NSDragOperationNone;这个时候拖动的图标不会有任何改变。
//
//     #imageLiteral(resourceName: "112008pix4iouowpbwz04m.png")
//     这里是对拖拽进来的内容做 一些提前处理，例如显示对应的额图标等
//     */
//    override func draggingEntered(_ sender: NSDraggingInfo) -> NSDragOperation {
//        if sender.draggingPasteboard.types?.contains(draggedType) ?? false {
//            return .copy
//        }
//        return NSDragOperation()
//    }
//    /**
//    第三步：#imageLiteral(resourceName: "README.pdf")
//    当在view中松开鼠标键时会触发以下函数，我们可以在这个函数里面处理接受到的数据
//     */
//    override func performDragOperation(_ sender: NSDraggingInfo) -> Bool {
//        // 1. h获取 拖动数据中的粘贴板
//        let board = sender.draggingPasteboard
//        // 2. 从粘贴板中提取到具体的内容
//
//        guard let list = board.propertyList(forType: draggedType) as? [String] else { return false }
//        // 3. 将文件链接数据通过代理传送
//        self.delegate?.process(list)
//        return true
//    }
//    override func prepareForDragOperation(_ sender: NSDraggingInfo) -> Bool {
//        return true
//    }
//}
//
//
////        if board.types?.contains(draggedType) ?? false {
////            return .copy
////        }
//
////        let pasteBoard = sender.draggingPasteboard
////        let accept = NSImage(pasteboard: pasteBoard) != nil
////        return accept ? .copy : NSDragOperation()
////    private let typeArray = ["NSTypedFilenamesPboardType:jpg",
////           "NSTypedFilenamesPboardType:JPG",
////           "NSTypedFilenamesPboardType:jpeg",
////           "NSTypedFilenamesPboardType:JPEG",
////           "NSTypedFilenamesPboardType:jpe",
////           "NSTypedFilenamesPboardType:TIF"]
