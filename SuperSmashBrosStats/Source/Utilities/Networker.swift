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

struct Networker {
    static private let baseUrl = "http://127.0.0.1:4000/v1/api"

    static func getCharacters(game: Game, completion: @escaping (Result<[CodableCharacter], Error>) -> Void) {
        DispatchQueue.apiCallThread.async {
            switch game {
            case .smash4:
                completion(.success(smash4CharactersData))
            case .ultimate:
                completion(.success(ultimateCharactersData))
            }
        }
    }

    // swiftlint:disable:next line_length
    static func getCharacterMoves(game: Game, characterId: Int, completion: @escaping (Result<[CodableCharacterMoves], Error>) -> Void) {
        DispatchQueue.apiCallThread.async {
            if let characterMoves = ResponderHolder.shared.getCharacterMoves(game: game, characterId: characterId) {
                completion(.success(characterMoves))
            } else {
                Self.get(
                [CodableCharacterMoves].self,
                from: "/characters/\(game.rawValue)/moves/\(characterId)") { result in
                    completion(result)
                }
            }
        }
    }

    // swiftlint:disable:next line_length
    static func getCharacterAttributes(game: Game, characterId: Int, completion:  @escaping (Result<[CodableCharacterAttributes], Error>) -> Void) {
        DispatchQueue.apiCallThread.async {
            if let characterAttribute = ResponderHolder.shared.getCharacterAttributes(
                game: game,
                characterId: characterId) {
                completion(.success(characterAttribute))
            } else {
                switch game {
                case .smash4:
                    Self.get(
                    [CodableCharacterAttributes].self,
                    from: "/characters/\(game.rawValue)/characterattributes/\(characterId)") { result in
                        completion(result)
                    }
                case .ultimate:
                    let path = "characterAttributes-\(game.rawValue)-\(characterId).json"
                    let characterData: [CodableCharacterAttributes] = load(path)
                    completion(.success(characterData))
                }
            }
        }
    }

    static func loadImage(from imageUrl: String, completion: @escaping (Result<Data, Error>) -> Void) {
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

    // swiftlint:disable:next line_length
    static private func get<T: Codable>(_ type: T.Type, from path: String, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = URL(string: "\(Self.baseUrl)\(path)") else {
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
