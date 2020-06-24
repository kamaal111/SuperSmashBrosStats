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
        if let savedAppColor = colorName {
            if savedAppColor == AppColors.tealAppColor.rawValue {
                return .systemTeal
            } else if savedAppColor == AppColors.greenAppColor.rawValue {
                return .systemGreen
            } else if savedAppColor == AppColors.orangeAppColor.rawValue {
                return .systemOrange
            } else if savedAppColor == AppColors.pinkAppColor.rawValue {
                return .systemPink
            } else if savedAppColor == AppColors.purpleAppColor.rawValue {
                return .systemPurple
            } else if savedAppColor == AppColors.redAppColor.rawValue {
                return .systemRed
            } else if savedAppColor == AppColors.yellowAppColor.rawValue {
                return .systemYellow
            } else if savedAppColor == AppColors.blueAppColor.rawValue {
                return .systemBlue
            } else {
                return .systemTeal
            }
        } else {
            return .systemBlue
        }
    }
}
