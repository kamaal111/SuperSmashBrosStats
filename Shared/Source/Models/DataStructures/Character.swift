//
//  Character.swift
//  SuperSmashBrosStats
//
//  Created by Kamaal Farah on 06/06/2020.
//  Copyright © 2020 Kamaal. All rights reserved.
//

import SwiftUI

struct CodableCharacter: Codable, Hashable, Identifiable {
    let colorTheme: String
    let displayName: String
    let name: String
    let id: String // swiftlint:disable:this identifier_name
    let ownerId: Int
    let fullUrl: String
    let mainImageUrl: String
    let thumbnailUrl: String
    let game: String
    let related: CodableRelated

    var colorThemeRGB: Color {
        let rgb = ColorHelper.hexToRGB(hexString: colorTheme)
        return Color(red: rgb.red / 255, green: rgb.green / 255, blue: rgb.blue / 255)
    }

    private enum CodingKeys: String, CodingKey {
        case colorTheme = "ColorTheme"
        case displayName = "DisplayName"
        case name = "Name"
        case id = "InstanceId" // swiftlint:disable:this identifier_name
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

        private enum CodingKeys: String, CodingKey { // swiftlint:disable:this nesting
            case ultimate = "Ultimate"
            case smash4 = "Smash4"
        }
    }

    struct CodableRelatedLinks: Codable, Hashable {
        let itSelf: String
        let moves: String

        private enum CodingKeys: String, CodingKey { // swiftlint:disable:this nesting
            case itSelf = "Self"
            case moves = "Moves"
        }
    }
}

struct Character: Hashable, Identifiable {
    let id: String // swiftlint:disable:this identifier_name
    let details: CodableCharacter
    var cachedThumbnailUrl: Data?

    // swiftlint:disable:next identifier_name
    init(id: String, details: CodableCharacter, cachedThumbnailUrl: Data? = nil) {
        self.id = id
        self.details = details
        self.cachedThumbnailUrl = cachedThumbnailUrl
    }
}
