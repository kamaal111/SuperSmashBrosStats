//
//  Networker.swift
//  SuperSmashBrosStats
//
//  Created by Kamaal Farah on 06/06/2020.
//  Copyright © 2020 Kamaal. All rights reserved.
//

import Foundation

enum Game: String {
    case ultimate
    case smash4
}

struct Networker: Networkable {
    private let baseUrl = "http://127.0.0.1:4000/v1/api"

    init() { }

    func getCharacters(game: Game, completion: @escaping (Result<[CodableCharacter], Error>) -> Void) {
        DispatchQueue.apiCallThread.async {
            switch game {
            case .smash4:
                completion(.success(smash4CharactersData))
            case .ultimate:
                completion(.success(ultimateCharactersData))
            }
        }
    }

    func getCharacterMoves(game: Game, characterId: Int, completion: @escaping (Result<[CodableCharacterMoves], Error>) -> Void) {
        // swiftlint:disable:previous line_length
        DispatchQueue.apiCallThread.async {
            if let characterMoves = ResponderHolder.shared.getCharacterMoves(game: game, characterId: characterId) {
                completion(.success(characterMoves))
            } else {
                let path = "charactermoves-\(game.rawValue)-\(characterId).json"
                let characterMoves: [CodableCharacterMoves] = load(path)
                completion(.success(characterMoves))
            }
        }
    }

    func getCharacterAttributes(game: Game, characterId: Int, completion:  @escaping (Result<[CodableCharacterAttributes], Error>) -> Void) {
        // swiftlint:disable:previous line_length
        DispatchQueue.apiCallThread.async {
            if let characterAttribute = ResponderHolder.shared.getCharacterAttributes(
                game: game,
                characterId: characterId) {
                completion(.success(characterAttribute))
            } else {
                let path = "characterattributes-\(game.rawValue)-\(characterId).json"
                let characterData: [CodableCharacterAttributes] = load(path)
                completion(.success(characterData))
            }
        }
    }

    func loadImage(from imageUrl: String, completion: @escaping (Result<Data, Error>) -> Void) {
        DispatchQueue.loadImageThread.async {
            guard let url = URL(string: imageUrl) else {
                completion(.failure(NSError(domain: "url error", code: 400, userInfo: nil)))
                return
            }
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                guard (response as? HTTPURLResponse) != nil else {
                    completion(.failure(NSError(domain: "response code error", code: 400, userInfo: nil)))
                    return
                }
                guard let dataResponse = data else {
                    completion(.failure(NSError(domain: "data error", code: 400, userInfo: nil)))
                    return
                }
                completion(.success(dataResponse))
            }
            .resume()
        }
    }

    private func get<T: Codable>(_ type: T.Type, from path: String, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = URL(string: "\(self.baseUrl)\(path)") else {
            completion(.failure(NSError(domain: "url error", code: 400, userInfo: nil)))
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            do {
                guard let dataResponse = data else {
                    completion(.failure(NSError(domain: "data error", code: 400, userInfo: nil)))
                    return
                }
                let decoder = JSONDecoder()
                let jsonResponse = try decoder.decode(type, from: dataResponse)
                guard (response as? HTTPURLResponse) != nil else {
                    completion(.failure(NSError(domain: "response error", code: 400, userInfo: nil)))
                    return
                }
                completion(.success(jsonResponse))
            } catch let parsingError {
                completion(.failure(parsingError))
            }
        }
        .resume()
    }
}
