//
//  NSSplitView+Exts.swift
//  Pods-TKCocoaModule_Example
//
//  Created by 聂子 on 2019/10/7.
//

import Foundation

@available(OSX 10.11, *)
extension NSSplitView {

    enum FixableSide {
        case begin
        case end
    }

    class Fixable: NSObject {

        weak private var splitView: NSSplitView?

        var side: FixableSide = .begin

        var previousSize: CGFloat = 0

        init(splitView: NSSplitView) {
            super.init()
            self.splitView = splitView
            DispatchQueue.main.async {
                NotificationCenter.default.addObserver(self, selector: #selector(self.windowWillResize(notification:)),
                                                       name: NSWindow.willStartLiveResizeNotification, object: nil)
                NotificationCenter.default.addObserver(self, selector: #selector(self.windowDidResize(notification:)),
                                                       name: NSWindow.didResizeNotification, object: nil)
            }
        }

        deinit {
            NotificationCenter.default.removeObserver(self)
        }


        var fixedView: NSView? {
            if side == .begin {
                return splitView?.arrangedSubviews.first
            } else {
                return splitView?.arrangedSubviews.last
            }
        }

        var recordedSize: CGFloat {
            if splitView?.isVertical == true {
                return fixedView?.frame.width ?? 0
            }
            return fixedView?.frame.height ?? 0
        }

        func adjustSplitViewPosition() {
            if splitView == nil {
                return
            }
            if side == .begin {
                splitView!.setPosition(previousSize, ofDividerAt: 0)
            } else {
                if splitView!.isVertical {
                    splitView!.setPosition(splitView!.frame.width - previousSize, ofDividerAt: splitView!.arrangedSubviews.count - 2)
                } else {
                    splitView!.setPosition(splitView!.frame.height - previousSize, ofDividerAt: splitView!.arrangedSubviews.count - 2)
                }
            }
        }

        @objc func windowWillResize(notification: Notification) {
            if notification.object as? NSWindow != splitView?.window {
                return
            }
            previousSize = recordedSize
        }

        @objc func windowDidResize(notification: Notification) {
            if notification.object as? NSWindow != splitView?.window {
                return
            }
            adjustSplitViewPosition()
        }

    }

    private static var fixableVariableKey: UInt = 666666

    private var fixable: Fixable? {
        get {
            return objc_getAssociatedObject(self, &NSSplitView.fixableVariableKey) as? Fixable
        }
        set {
            objc_setAssociatedObject(self, &NSSplitView.fixableVariableKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    var fixableSide: FixableSide? {
        get {
            return fixable?.side
        }
        set {
            if newValue == nil {
                fixable = nil
            } else {
                if let fixable = self.fixable {
                    fixable.side = newValue!
                } else {
                    let fixable = Fixable.init(splitView: self)
                    fixable.side = newValue!
                    self.fixable = fixable
                }
            }
        }
    }

}
