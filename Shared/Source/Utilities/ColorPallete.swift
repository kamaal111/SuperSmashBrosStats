//
//  ColorPallete.swift
//  SuperSmashBrosStats
//
//  Created by Kamaal Farah on 24/06/2020.
//  Copyright © 2020 Kamaal. All rights reserved.
//

import SwiftUI

enum AppColors: String {
    case tealAppColor = "Teal"
    case purpleAppColor = "Purple"
    case greenAppColor = "Green"
    case yellowAppColor = "Yellow"
    case pinkAppColor = "Pink"
    case orangeAppColor = "Orange"
    case redAppColor = "Red"
    case blueAppColor = "Blue"
}

extension Color {
    /// This color is derived from UIColor.systemTeal
    static let TealAppColor = Color(.systemTeal)
    /// This color is derived from UIColor.systemPurple
    static let PurpleAppColor = Color(.systemPurple)
    /// This color is derived from UIColor.systemGreen
    static let GreenAppColor = Color(.systemGreen)
    /// This color is derived from UIColor.systemYellow
    static let YellowAppColor = Color(.systemYellow)
    /// This color is derived from UIColor.systemPink
    static let PinkAppColor = Color(.systemPink)
    /// This color is derived from UIColor.systemOrange
    static let OrangeAppColor = Color(.systemOrange)
    /// This color is derived from UIColor.systemRed
    static let RedAppColor = Color(.systemRed)
    /// This color is derived from UIColor.systemRed
    static let BlueAppColor = Color(.systemBlue)

    static func getAppColor(from colorName: String?) -> Color {
        if let savedAppColor = colorName {
            if savedAppColor == AppColors.tealAppColor.rawValue {
                return .TealAppColor
            } else if savedAppColor == AppColors.greenAppColor.rawValue {
                return .GreenAppColor
            } else if savedAppColor == AppColors.orangeAppColor.rawValue {
                return .OrangeAppColor
            } else if savedAppColor == AppColors.pinkAppColor.rawValue {
                return .PinkAppColor
            } else if savedAppColor == AppColors.purpleAppColor.rawValue {
                return .PurpleAppColor
            } else if savedAppColor == AppColors.redAppColor.rawValue {
                return .RedAppColor
            } else if savedAppColor == AppColors.yellowAppColor.rawValue {
                return .YellowAppColor
            } else if savedAppColor == AppColors.blueAppColor.rawValue {
                return .BlueAppColor
            } else {
                return .TealAppColor
            }
        } else {
            return .TealAppColor
        }
    }
}

struct ColorOption: Identifiable, Hashable {
    let id: Int // swiftlint:disable:this identifier_name
    let color: Color
    let name: AppColors
}

let appColors: [ColorOption] = [
    ColorOption(id: 0, color: .TealAppColor, name: AppColors.tealAppColor),
    ColorOption(id: 1, color: .YellowAppColor, name: AppColors.yellowAppColor),
    ColorOption(id: 2, color: .PurpleAppColor, name: AppColors.purpleAppColor),
    ColorOption(id: 3, color: .PinkAppColor, name: AppColors.pinkAppColor),
    ColorOption(id: 4, color: .OrangeAppColor, name: AppColors.orangeAppColor),
    ColorOption(id: 5, color: .GreenAppColor, name: AppColors.greenAppColor),
    ColorOption(id: 6, color: .RedAppColor, name: AppColors.redAppColor),
    ColorOption(id: 7, color: .BlueAppColor, name: AppColors.blueAppColor)
]
