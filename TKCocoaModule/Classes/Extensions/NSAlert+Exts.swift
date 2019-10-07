//
//  NSAlert+Exts.swift
//  Queen
//
//  Created by 聂子 on 2019/8/4.
//  Copyright © 2019 聂子. All rights reserved.
//

import Cocoa


extension TypeWrapperProtocol where WrappedType == NSAlert {

    /// alert
    ///
    /// - Parameters:
    ///   - stlye: style
    ///   - message: message
    ///   - information: information description
    ///   - titles: titles description
    ///   - complation: complation description
    public static func alert(stlye:NSAlert.Style,
                      message: String,
                      information:String,
                      button titles:[String], complation:@escaping (Bool) ->Void) {

        let alert = NSAlert.init()
        alert.messageText = message
        alert.informativeText = information
        alert.alertStyle = stlye
        titles.forEach { (t) in
            alert.addButton(withTitle: t)
        }

        if let window = NSApp.mainWindow {
            alert.beginSheetModal(for: window) { (result) in
                complation(result == .OK)
            }
        }else {
            complation(alert.runModal().rawValue == NSApplication.ModalResponse.alertFirstButtonReturn.rawValue)
        }
    }
}
