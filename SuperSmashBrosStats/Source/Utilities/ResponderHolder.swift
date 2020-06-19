//
//  ResponderHolder.swift
//  SuperSmashBrosStats
//
//  Created by Kamaal Farah on 13/06/2020.
//  Copyright © 2020 Kamaal. All rights reserved.
//

import Foundation

class ResponderHolder {

    private var characterMoves = [String: [CodableCharacterMoves]]()
    private var characterAttributes = [String: [CodableCharacterAttributes]]()

    private init() { }

    static let shared = ResponderHolder()

    func reset() {
        self.characterMoves = [:]
        self.characterAttributes = [:]
    }

    func getCharacterMoves(game: Game, characterId: Int) -> [CodableCharacterMoves]? {
        return self.characterMoves["\(game.rawValue)-\(characterId)"]
    }

    func setCharacterMoves(game: Game, characterId: Int, characterMoves: [CodableCharacterMoves]) {
        self.characterMoves["\(game.rawValue)-\(characterId)"] = characterMoves
    }

    func getCharacterAttributes(game: Game, characterId: Int) -> [CodableCharacterAttributes]? {
        return self.characterAttributes["\(game.rawValue)-\(characterId)"]
    }

    func setCharacterAttributes(game: Game, characterId: Int, characterAttributes: [CodableCharacterAttributes]) {
        self.characterAttributes["\(game.rawValue)-\(characterId)"] = characterAttributes
    }

}
