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

    @Published var characterMoves = [CodableCharacterMoves]()
    @Published var characterAttributes = [CodableCharacterAttributes]()

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
            self?.handleCharacterMovesResult(result: result)
        }
        Networker.getCharacterAttributes(characterId: self.character.details.ownerId) { [weak self] result in
            self?.handleCharacterAttributesResult(result: result)
        }
    }

    private func handleCharacterMovesResult(result: Result<[CodableCharacterMoves], Error>) {
        switch result {
        case .failure(let failure):
            self.analys("*** Failure -> \(failure)")
        case .success(let characterMoves):
            DispatchQueue.main.async {
                self.characterMoves = characterMoves
            }
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
