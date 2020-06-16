//
//  CharacterDetailScreenViewModel.swift
//  SuperSmashBrosStats
//
//  Created by Kamaal Farah on 07/06/2020.
//  Copyright © 2020 Kamaal. All rights reserved.
//

import Combine
import SwiftUI

final class CharacterDetailScreenViewModel: ObservableObject {

    @Published var characterAttributes = [CodableCharacterAttributes]()
    @Published var settingFavorite = false

    var character: Character

    private var kowalskiAnalysis: Bool

    init(character: Character, kowalskiAnalysis: Bool = false) {
        self.kowalskiAnalysis = kowalskiAnalysis
        self.character = character
        if let characterAttributes = ResponderHolder.shared.getCharacterAttributes(game: .ultimate, characterId: character.details.ownerId) {
            self.characterAttributes = characterAttributes
        }
    }

    var uniqueAttributes: [CodableCharacterAttributes] {
        var uniqueValues = [CodableCharacterAttributes]()
        var uniqueAttributeNames = [String]()
        for stats in self.characterAttributes where !uniqueAttributeNames.contains(stats.name) {
            uniqueValues.append(stats)
            uniqueAttributeNames.append(stats.name)
        }
        return uniqueValues
    }

    func populateCharacterAttributes() {
        if self.characterAttributes.isEmpty {
            let characterId = self.character.details.ownerId
            self.analys("Owner id: \(characterId)")
            let game: Game = .ultimate
            Networker.getCharacterAttributes(game: game, characterId: characterId) { [weak self] result in
                self?.handleCharacterAttributesResult(game: game, characterId: characterId, result: result)
            }
        }
    }

    private func handleCharacterAttributesResult(game: Game, characterId: Int, result: Result<[CodableCharacterAttributes], Error>) {
        switch result {
        case .failure(let failure):
            self.analys("*** Failure -> \(failure)")
        case .success(let characterAttributes):
            DispatchQueue.main.async {
                ResponderHolder.shared.setCharacterAttributes(
                    game: game,
                    characterId: characterId,
                    characterAttributes: characterAttributes)
                self.characterAttributes = characterAttributes
            }
        }
    }

    private func analys(_ message: String) {
        if kowalskiAnalysis {
            print(message)
        }
    }

}
