//
//  MockNetworker.swift
//  SuperSmashBrosStatsTests
//
//  Created by Kamaal Farah on 19/06/2020.
//  Copyright © 2020 Kamaal. All rights reserved.
//

import Foundation
import UIKit
@testable import SuperSmashBrosStats

struct MockNetworker: Networkable {
    func getCharacters(game: Game, completion: @escaping (Result<[CodableCharacter], Error>) -> Void) {
        let character = ultimateCharactersData
        completion(.success(character))
    }

    func getCharacterMoves(game: Game, characterId: Int, completion: @escaping (Result<[CodableCharacterMoves], Error>) -> Void) {
        // swiftlint:disable:previous line_length
        let characterMoves = [CodableCharacterMoves(
            id: "1",
            name: "The move",
            ownerId: 1,
            owner: "Kamaal",
            hitboxActive: "3/4/5",
            firstActionableFrame: "20",
            baseDamage: "3001",
            angle: "90",
            baseKnockBackSetKnockback: "30",
            landingLag: "0",
            autoCancel: "40>",
            knockbackGrowth: "20",
            moveType: CodableCharacterMoves.MoveType.aerial,
            isWeightDependent: true,
            game: "ultimate2",
            related: CodableCharacterMoves.CodableRelated(ultimate: nil, smash4: nil))]
        completion(.success(characterMoves))
    }

    func getCharacterAttributes(game: Game, characterId: Int, completion: @escaping (Result<[CodableCharacterAttributes], Error>) -> Void) {
        // swiftlint:disable:previous line_length
        let path = "characterAttributes-\(game.rawValue)-\(characterId).json"
        let characterData: [CodableCharacterAttributes] = load(path)
        completion(.success(characterData))
    }

    func loadImage(from imageUrl: String, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let image = UIImage(systemName: "smiley"), let data = image.jpegData(compressionQuality: 1) else {
            completion(.failure(NSError(domain: "OOPS", code: 500, userInfo: nil)))
            return
        }
        completion(.success(data))
    }
}
