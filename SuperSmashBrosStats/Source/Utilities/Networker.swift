//
//  Networker.swift
//  SuperSmashBrosStats
//
//  Created by Kamaal Farah on 06/06/2020.
//  Copyright © 2020 Kamaal. All rights reserved.
//

import Foundation

class Networker {

    static func getCharacters(completion: @escaping (Result<[Character], Error>) -> ()) {
        DispatchQueue(label: "api-call-thread", qos: .utility, attributes: .concurrent).async {
            let charactersData: [Character] = load("characters.json")
            completion(.success(charactersData))
        }
    }

    static private let baseUrl = "https://api.kuroganehammer.com/api"

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
        }.resume()
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
