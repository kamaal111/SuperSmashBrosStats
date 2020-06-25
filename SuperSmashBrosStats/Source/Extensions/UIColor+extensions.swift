//
//  UIColor+extensions.swift
//  SuperSmashBrosStats
//
//  Created by Kamaal Farah on 24/06/2020.
//  Copyright © 2020 Kamaal. All rights reserved.
//

import UIKit

extension UIColor {
    static func getAppColor(from colorName: String?) -> UIColor {
        guard let savedAppColor = colorName, let appColor = AppColors(rawValue: savedAppColor)
        else { return .systemBlue }
        switch appColor {
        case .blueAppColor:
            return .systemBlue
        case .greenAppColor:
            return .systemGreen
        case .orangeAppColor:
            return .systemOrange
        case .pinkAppColor:
            return .systemPink
        case .purpleAppColor:
            return .systemPurple
        case .redAppColor:
            return .systemRed
        case .tealAppColor:
            return .systemTeal
        case .yellowAppColor:
            return .systemYellow
        }
    }
}
