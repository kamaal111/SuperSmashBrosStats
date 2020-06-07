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

    static private let baseUrl = "https://api.kuroganehammer.com/api"

    static func getCharacters(completion: @escaping (Result<[CodableCharacter], Error>) -> ()) {
        DispatchQueue(label: "api-call-thread", qos: .utility, attributes: .concurrent).async {
            var smash4CharactersData: [CodableCharacter] = load("characters-\(Game.smash4.rawValue).json")
            var ultimateCharactersData: [CodableCharacter] = load("characters-\(Game.ultimate.rawValue).json")
            smash4CharactersData = smash4CharactersData.filter { smash4Character in
                !ultimateCharactersData.contains(where: { $0.displayName == smash4Character.displayName })
            }
            ultimateCharactersData = ultimateCharactersData + smash4CharactersData
            completion(.success(ultimateCharactersData))
        }
    }

    static func loadImage(from imageUrl: String, completion: @escaping (Result<Data, Error>) -> ()) {
        DispatchQueue(label: "load-image-thread", qos: .utility, attributes: .concurrent).async {
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

func load<T: Decodable>(_ filename: String) -> T {
    let data: Data

    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else { fatalError("Couldn't find \(filename) in main bundle.") }

    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }

    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}
