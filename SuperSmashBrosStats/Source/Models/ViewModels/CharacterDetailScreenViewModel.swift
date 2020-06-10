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

    @Published  var characterMoves = [CodableCharacterMoves]()

    var character: Character

    private var kowalskiAnalysis: Bool

    init(character: Character, kowalskiAnalysis: Bool = false) {
        self.kowalskiAnalysis = kowalskiAnalysis
        self.character = character
    }

    var categorizedCharacterMoves: [String: [CodableCharacterMoves]] {
        let characterMoves = self.characterMoves
        return Dictionary(grouping: characterMoves, by: { $0.moveType.rawValue })
    }

    func populateCharacterMoves() {
        self.analys("Owner id: \(self.character.details.ownerId)")
        Networker.getCharacterMoves(characterId: self.character.details.ownerId) { [weak self] result in
            switch result {
            case .failure(let failure):
                self?.analys("failure \(failure)")
            case .success(let characterMoves):
                self?.analys("characterMoves: \(characterMoves[0])")
                DispatchQueue.main.async {
                    self?.characterMoves = characterMoves
                }
            }
        }
    }

    private func analys(_ message: String) {
        if kowalskiAnalysis {
            print(message)
        }
    }

}
