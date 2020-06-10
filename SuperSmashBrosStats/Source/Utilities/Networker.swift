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

//    static private let baseUrl = "https://api.kuroganehammer.com/api"
    static private let baseUrl = "http://127.0.0.1:4000/v1/api"

    static func getCharacters(completion: @escaping (Result<[CodableCharacter], Error>) -> ()) {
        DispatchQueue.apiCallThread.async {
            var combinendSmashCharacters = smash4CharactersData.filter { smash4Character in
                !ultimateCharactersData.contains(where: { $0.displayName == smash4Character.displayName })
            }
            combinendSmashCharacters = ultimateCharactersData + combinendSmashCharacters
            completion(.success(combinendSmashCharacters))
        }
    }

    static func getCharacterMoves(characterId: Int, completion: @escaping (Result<[CodableCharacterMoves], Error>) -> ()) {
        DispatchQueue.apiCallThread.async {
            Self.get([CodableCharacterMoves].self, from: "/characters/ultimate/moves/\(characterId)") { result in
                completion(result)
            }
        }
    }

    static func loadImage(from imageUrl: String, completion: @escaping (Result<Data, Error>) -> ()) {
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

    static private func get<T: Codable>(_ type: T.Type, from path: String, completion: @escaping (Result<T, Error>) -> ()) {
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
                let jsonResponse = try JSONDecoder().decode(type, from: dataResponse)
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
