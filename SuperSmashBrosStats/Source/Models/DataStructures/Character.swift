//
//  Character.swift
//  SuperSmashBrosStats
//
//  Created by Kamaal Farah on 06/06/2020.
//  Copyright © 2020 Kamaal. All rights reserved.
//

import Foundation

struct CodableCharacter: Codable, Hashable, Identifiable {
    let colorTheme: String
    let displayName: String
    let name: String
    let id: String
    let ownerId: Int
    let fullUrl: String
    let mainImageUrl: String
    let thumbnailUrl: String
    let game: String
    let related: CodableRelated

    var colorThemeRGB: RedGreenBlue {
        return ColorHelper.hexToRGB(hexString: colorTheme)
    }

    private enum CodingKeys: String, CodingKey {
        case colorTheme = "ColorTheme"
        case displayName = "DisplayName"
        case name = "Name"
        case id = "InstanceId"
        case ownerId = "OwnerId"
        case fullUrl = "FullUrl"
        case mainImageUrl = "MainImageUrl"
        case thumbnailUrl = "ThumbnailUrl"
        case game = "Game"
        case related = "Related"
    }

    struct CodableRelated: Codable, Hashable {
        let ultimate: CodableRelatedLinks?
        let smash4: CodableRelatedLinks?

        private enum CodingKeys: String, CodingKey {
            case ultimate = "Ultimate"
            case smash4 = "Smash4"
        }
    }

    struct CodableRelatedLinks: Codable, Hashable {
        let itSelf: String
        let moves: String

        private enum CodingKeys: String, CodingKey {
            case itSelf = "Self"
            case moves = "Moves"
        }
    }
}

struct Character: Hashable, Identifiable {
    let id: String
    let character: CodableCharacter
    var cachedThumbnailUrl: Data?

    init(id: String, character: CodableCharacter, cachedThumbnailUrl: Data? = nil) {
        self.id = id
        self.character = character
        self.cachedThumbnailUrl = cachedThumbnailUrl
    }
}
