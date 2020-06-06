//
//  Character.swift
//  SuperSmashBrosStats
//
//  Created by Kamaal Farah on 06/06/2020.
//  Copyright © 2020 Kamaal. All rights reserved.
//

import Foundation

struct Character: Codable, Hashable, Identifiable {
    let colorTheme: String
    let displayName: String
    let id: String
    let ownerId: Int
    let fullUrl: String
    let mainImageUrl: String
    let thumbnailUrl: String
    let game: String
    let related: Related

    var colorThemeRGB: RedGreenBlue {
        return ColorHelper.hexToRGB(hexString: colorTheme)
    }

    struct Related: Codable, Hashable {
        let ultimate: Ultimate

        struct Ultimate: Codable, Hashable {
            let itSelf: String
            let moves: String

            private enum CodingKeys: String, CodingKey {
                case itSelf = "Self"
                case moves = "Moves"
            }
        }

        private enum CodingKeys: String, CodingKey {
            case ultimate = "Ultimate"
        }
    }

    private enum CodingKeys: String, CodingKey {
        case colorTheme = "ColorTheme"
        case displayName = "DisplayName"
        case id = "InstanceId"
        case ownerId = "OwnerId"
        case fullUrl = "FullUrl"
        case mainImageUrl = "MainImageUrl"
        case thumbnailUrl = "ThumbnailUrl"
        case game = "Game"
        case related = "Related"
    }
}
