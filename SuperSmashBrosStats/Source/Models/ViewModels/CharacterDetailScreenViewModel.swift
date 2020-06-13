//
//  CharacterDetailScreenViewModel.swift
//  SuperSmashBrosStats
//
//  Created by Kamaal Farah on 07/06/2020.
//  Copyright © 2020 Kamaal. All rights reserved.
//

import Combine
import SwiftUI

class CharacterDetailScreenViewModel: ObservableObject {

    @Published var characterAttributes = [CodableCharacterAttributes]()

    var character: Character

    private var kowalskiAnalysis: Bool

    init(character: Character, kowalskiAnalysis: Bool = false) {
        self.kowalskiAnalysis = kowalskiAnalysis
        self.character = character
    }

    var uniqueAttributes: [CodableCharacterAttributes] {
        var uniqueValues = [CodableCharacterAttributes]()
        var uniqueAttributeNames = [String]()
        for stats in self.characterAttributes.reversed() where !uniqueAttributeNames.contains(stats.name) {
            uniqueValues.append(stats)
            uniqueAttributeNames.append(stats.name)
        }
        return uniqueValues
    }

    func populateCharacterAttributes() {
        self.analys("Owner id: \(self.character.details.ownerId)")
        Networker.getCharacterAttributes(characterId: self.character.details.ownerId) { [weak self] result in
            self?.handleCharacterAttributesResult(result: result)
        }
    }

    private func handleCharacterAttributesResult(result: Result<[CodableCharacterAttributes], Error>) {
        switch result {
        case .failure(let failure):
            self.analys("*** Failure -> \(failure)")
        case .success(let characterAttributes):
            DispatchQueue.main.async {
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
