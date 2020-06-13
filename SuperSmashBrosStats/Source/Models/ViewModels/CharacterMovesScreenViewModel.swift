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

    private func analys(_ message: String) {
        if kowalskiAnalysis {
            print(message)
        }
    }

}
