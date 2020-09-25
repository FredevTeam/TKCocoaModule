//
//  NSWindowController+Exts.swift
//  TKCocoaModule
//
//  Created by 聂子 on 2020/6/2.
//

import Cocoa


extension TypeWrapperProtocol where WrappedType: NSWindowController {

    public static func show(name: String, storyboard: String = "Main", complation:((_ windowController: NSWindowController?) ->Void)) {
        guard let controller = NSStoryboard.cocoa.windowController(name: name, storyboard: NSStoryboard.Name(storyboard)) else {
                  complation(nil)
                    return
              }
        complation(controller)
    }

}
