//
//  NSColor+Exts.swift
//  TKAppKitModule
//
//  Created by 聂子 on 2019/10/7.
//

import AppKit
import Foundation


extension TypeWrapperProtocol where WrappedType: NSColor {
    /// 随机色
    public static var randomColor: NSColor {
        get
        {
            let red = CGFloat(arc4random()%256)/255.0
            let green = CGFloat(arc4random()%256)/255.0
            let blue = CGFloat(arc4random()%256)/255.0
            return NSColor(red: red, green: green, blue: blue, alpha: 1.0)
        }
    }


    /// 随机色
    ///
    /// - Returns: 随机色
    //   public static func randomColor() -> NSColor {
    //        return self.randomColor
    //    }

    /// 获取颜色，通过16进制色值字符串，e.g. #ff0000， ff0000
    ///
    /// - Parameters:
    ///   - hex: 16进制字符串
    ///   - alpha: 透明度，默认为1，不透明
    /// - Returns: RGB
    public static func withHex(hexString hex: String, alpha:CGFloat = 1) -> NSColor {
        // 去除空格等
        var cString: String = hex.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines).uppercased()
        // 去除#
        if (cString.hasPrefix("#")) {
            cString = (cString as NSString).substring(from: 1)
        }
        // 必须为6位
        if (cString.count != 6) {
            return NSColor.gray
        }
        // 红色的色值
        let rString = (cString as NSString).substring(to: 2)
        let gString = ((cString as NSString).substring(from: 2) as NSString).substring(to: 2)
        let bString = ((cString as NSString).substring(from: 4) as NSString).substring(to: 2)
        // 字符串转换
        var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0
        Scanner(string: rString).scanHexInt32(&r)
        Scanner(string: gString).scanHexInt32(&g)
        Scanner(string: bString).scanHexInt32(&b)

        return NSColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: alpha)
    }

    /// 获取颜色，通过16进制数值
    ///
    /// - Parameters:
    ///   - hex: 16进制数值
    ///   - alpha: 透明度
    /// - Returns: Color
    public static func withHex(hexInt hex:Int32, alpha:CGFloat = 1) -> NSColor {
        let r = CGFloat((hex & 0xff0000) >> 16) / 255
        let g = CGFloat((hex & 0xff00) >> 8) / 255
        let b = CGFloat(hex & 0xff) / 255
        return NSColor(red: r, green: g, blue: b, alpha: alpha)
    }

    /// 获取颜色，通过rgb
    ///
    /// - Parameters:
    ///   - red: 红色
    ///   - green: 绿色
    ///   - blue: 蓝色
    /// - Returns: color
    public static func withRGB(_ red:CGFloat, _ green:CGFloat, _ blue:CGFloat) -> NSColor {
        return NSColor.cocoa.withRGBA(red, green, blue, 1)
    }
    /// 获取颜色，通过rgb
    ///
    /// - Parameters:
    ///   - red: 红色
    ///   - green: 绿色
    ///   - blue: 蓝色
    ///   - alpha: 透明度
    /// - Returns: color
    public static func withRGBA(_ red:CGFloat, _ green:CGFloat, _ blue:CGFloat, _ alpha:CGFloat) -> NSColor {
        return NSColor(red: red / 255, green: green / 255, blue: blue / 255, alpha: alpha)
    }




    /// hex string
    public var hexString: String {
        let components: [Int] = {
            let comps = self.wrappedValue.cgColor.components!
            let components = comps.count == 4 ? comps : [comps[0], comps[0], comps[0], comps[1]]
            return components.map { Int($0 * 255.0) }
        }()
        return String(format: "#%02X%02X%02X", components[0], components[1], components[2])
    }
}

