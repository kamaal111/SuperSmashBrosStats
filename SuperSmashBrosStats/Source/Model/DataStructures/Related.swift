//
//  Related.swift
//  SuperSmashBrosStats
//
//  Created by Kamaal Farah on 06/06/2020.
//  Copyright © 2020 Kamaal. All rights reserved.
//

import Foundation

struct Related: Codable, Hashable {
    let ultimate: RelatedLinks?
    let smash4: RelatedLinks?

    private enum CodingKeys: String, CodingKey {
        case ultimate = "Ultimate"
        case smash4 = "Smash4"
    }
}

struct RelatedLinks: Codable, Hashable {
    let itSelf: String
    let moves: String

    private enum CodingKeys: String, CodingKey {
        case itSelf = "Self"
        case moves = "Moves"
    }
}
