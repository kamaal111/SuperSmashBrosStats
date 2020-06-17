//
//  CharacterMovesScreenViewModel.swift
//  SuperSmashBrosStats
//
//  Created by Kamaal Farah on 12/06/2020.
//  Copyright © 2020 Kamaal. All rights reserved.
//

import Combine
import SwiftUI

final class CharacterMovesScreenViewModel: ObservableObject {

    @Published var characterMoves = [CodableCharacterMoves]()

    var character: Character

    private var kowalskiAnalysis: Bool

    init(character: Character, kowalskiAnalysis: Bool = false) {
        self.kowalskiAnalysis = kowalskiAnalysis
        self.character = character
        if let characterMoves = ResponderHolder.shared.getCharacterMoves(
            game: .ultimate,
            characterId: character.details.ownerId) {
            self.characterMoves = characterMoves
        }
    }

    var categorizedCharacterMoves: [String: [CodableCharacterMoves]] {
        let characterMoves = self.characterMoves
        return Dictionary(grouping: characterMoves, by: { $0.moveType.rawValue })
    }

    func populateCharacterMoves() {
        if self.characterMoves.isEmpty {
            let characterId = self.character.details.ownerId
            self.analys("Owner id: \(characterId)")
            let game: Game = .ultimate
            Networker.getCharacterMoves(game: game, characterId: characterId) { [weak self] result in
                self?.handleCharacterMovesResult(game: game, characterId: characterId, result: result)
            }
        }
    }

    // swiftlint:disable:next line_length
    private func handleCharacterMovesResult(game: Game, characterId: Int, result: Result<[CodableCharacterMoves], Error>) {
        switch result {
        case .failure(let failure):
            self.analys("*** Failure -> \(failure)")
        case .success(let characterMoves):
            ResponderHolder.shared.setCharacterMoves(
                game: game,
                characterId: characterId,
                characterMoves: characterMoves)
            DispatchQueue.main.async {
                self.characterMoves = characterMoves
            }
        }
    }

    private func analys(_ message: String) {
        if kowalskiAnalysis {
            print(message)
        }
    }

}
