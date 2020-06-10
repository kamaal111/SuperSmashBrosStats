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

    private var kowalskiAnalysis: Bool

    init(kowalskiAnalysis: Bool = false) {
        self.kowalskiAnalysis = kowalskiAnalysis
    }

    func populateCharacterMoves(of characterId: Int) {
        print("characterId", characterId)
        Networker.getCharacterMoves(characterId: characterId) { [weak self] result in
            switch result {
            case .failure(let failure):
                self?.analys("failure \(failure)")
            case .success(let characterMoves):
                self?.analys("characterMoves: \(characterMoves)")
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
