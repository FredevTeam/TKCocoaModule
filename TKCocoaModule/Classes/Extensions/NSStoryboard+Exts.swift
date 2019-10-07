//
//  NSStoryboard+Exts.swift
//  TKAppKitModule
//
//  Created by 聂子 on 2019/10/7.
//

import Cocoa


extension TypeWrapperProtocol where WrappedType == NSStoryboard {

    public static func viewController(from storyboard: String, bundle: Bundle? = nil) -> NSViewController? {
        return NSStoryboard.init(name: storyboard, bundle: bundle).instantiateInitialController() as? NSViewController
    }

    public static func windowController(from storyboard: String, bundle: Bundle? = nil) -> NSWindowController? {
        return NSStoryboard.init(name: storyboard, bundle: bundle).instantiateInitialController() as? NSWindowController
    }

    public static func viewController(name: String, storyboard from: String, bundle: Bundle? = nil) -> NSViewController? {
        return NSStoryboard.init(name: from, bundle: bundle).instantiateController(withIdentifier: name) as? NSViewController
    }

    public static func windowController(name: String, storyboard from: String, bundle: Bundle? = nil) -> NSWindowController? {
        return NSStoryboard.init(name: from, bundle: bundle).instantiateController(withIdentifier: name) as? NSWindowController
    }
}
