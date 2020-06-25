//
//  Networkable.swift
//  SuperSmashBrosStats
//
//  Created by Kamaal Farah on 20/06/2020.
//  Copyright © 2020 Kamaal. All rights reserved.
//

import Foundation

protocol Networkable {

    func getCharacters(game: Game, completion: @escaping (Result<[CodableCharacter], Error>) -> Void)

    func getCharacterMoves(game: Game, characterId: Int, completion: @escaping (Result<[CodableCharacterMoves], Error>) -> Void)
    // swiftlint:disable:previous line_length

    func getCharacterAttributes(game: Game, characterId: Int, completion:  @escaping (Result<[CodableCharacterAttributes], Error>) -> Void)
    // swiftlint:disable:previous line_length

    func loadImage(from imageUrl: String, completion: @escaping (Result<Data, Error>) -> Void)

}
