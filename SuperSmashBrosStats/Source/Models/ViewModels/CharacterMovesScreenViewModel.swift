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
    private let networker: Networkable?

    init(character: Character, networker: Networkable = Networker(), kowalskiAnalysis: Bool = false) {
        self.kowalskiAnalysis = kowalskiAnalysis
        self.networker = networker
        self.character = character
        if let characterMoves = ResponderHolder.shared.getCharacterMoves(
            game: .ultimate,
            characterId: character.details.ownerId) {
            self.characterMoves = characterMoves
        }
    }

    var categorizedCharacterMoves: [String: [CodableCharacterMoves]] {
        return Dictionary(grouping: self.characterMoves, by: { $0.moveType.rawValue })
    }

    func populateCharacterMoves() {
        if self.characterMoves.isEmpty {
            let characterId = self.character.details.ownerId
            self.analys("Owner id: \(characterId)")
            let game: Game = .ultimate
            self.networker?.getCharacterMoves(game: game, characterId: characterId) { [weak self] result in
                self?.handleCharacterMovesResult(game: game, characterId: characterId, result: result)
            }
        }
    }

    private func handleCharacterMovesResult(game: Game, characterId: Int, result: Result<[CodableCharacterMoves], Error>) {
        // swiftlint:disable:previous line_length
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
