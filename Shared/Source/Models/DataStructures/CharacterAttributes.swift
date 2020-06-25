//
//  CharacterAttributes.swift
//  SuperSmashBrosStats
//
//  Created by Kamaal Farah on 10/06/2020.
//  Copyright © 2020 Kamaal. All rights reserved.
//

import Foundation

struct CodableCharacterAttributes: Codable, Hashable, Identifiable {
    let id: String // swiftlint:disable:this identifier_name
    let name: String
    let ownerId: Int
    let owner: String
    let values: [Values]
    let game: String
    let related: CodableRelated

    private enum CodingKeys: String, CodingKey {
        case id = "InstanceId" // swiftlint:disable:this identifier_name
        case name = "Name"
        case ownerId = "OwnerId"
        case owner = "Owner"
        case values = "Values"
        case game = "Game"
        case related = "Related"
    }

    struct Values: Codable, Hashable {
        let value: String
        let owner: String
        let ownerId: Int
        let name: String

        private enum CodingKeys: String, CodingKey { // swiftlint:disable:this nesting
            case value = "Value"
            case owner = "Owner"
            case ownerId = "OwnerId"
            case name = "Name"
        }
    }

    struct CodableRelated: Codable, Hashable {
        let ultimate: CodableRelatedLinks?
        let smash4: CodableRelatedLinks?

        private enum CodingKeys: String, CodingKey { // swiftlint:disable:this nesting
            case ultimate = "Ultimate"
            case smash4 = "Smash4"
        }

        struct CodableRelatedLinks: Codable, Hashable { // swiftlint:disable:this nesting
            let itSelf: String?
            let character: String?

            private enum CodingKeys: String, CodingKey { // swiftlint:disable:this nesting
                case itSelf = "Self"
                case character = "Character"
            }
        }
    }
}
