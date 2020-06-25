//
//  ColorHelper.swift
//  SuperSmashBrosStats
//
//  Created by Kamaal Farah on 06/06/2020.
//  Copyright © 2020 Kamaal. All rights reserved.
//

import Foundation

struct ColorHelper {
    private init() {}

    static func hexToRGB(hexString: String) -> RedGreenBlue {
        var hex = hexString.uppercased()

        if hex.hasPrefix("#") {
            hex.remove(at: hex.startIndex)
        }

        if hex.count != 6 {
            return RedGreenBlue(red: 127, green: 127, blue: 127)
        }

        var rgbValue: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&rgbValue)

        let red = Double((rgbValue & 0xFF0000) >> 16)
        let green = Double((rgbValue & 0x00FF00) >> 8)
        let blue = Double(rgbValue & 0x0000FF)

        return RedGreenBlue(red: red, green: green, blue: blue)
    }
}
