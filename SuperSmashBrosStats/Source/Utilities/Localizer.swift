//
//  Localizer.swift
//  SuperSmashBrosStats
//
//  Created by Kamaal Farah on 21/06/2020.
//  Copyright © 2020 Kamaal. All rights reserved.
//

import Foundation

struct Localizer {
    private init() {}

    static func getLocalizableString(of key: LocalizableKeys, with variables: [CVarArg] = []) -> String {
        let localizedString = NSLocalizedString(key.rawValue, comment: "")
        if variables.isEmpty { return localizedString }
        return String(format: localizedString, variables[0])
    }
}

// swiftlint:disable identifier_name
enum LocalizableKeys: String {
    case SUPER_SMASH_STATS
    case FAVORITES_ONLY
    case SEARCH
    case CHARACTERS
    case LOADING
    case NO_CHARACTERS_IN_FAVORITES
    case NO_CHARACTERS_WITH_NAME
    case SMASH_4_ROSTER
    case SMASH_ULTIMATE_ROSTER
    case CHARACTER_MOVES
    case ATTRIBUTES
    case SORT_ATTRIBUTES_BY
    case DESCENDING
    case ASCENDING
}
