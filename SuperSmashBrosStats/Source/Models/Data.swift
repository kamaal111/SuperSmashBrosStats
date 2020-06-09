//
//  Data.swift
//  SuperSmashBrosStats
//
//  Created by Kamaal Farah on 09/06/2020.
//  Copyright © 2020 Kamaal. All rights reserved.
//

import Foundation

let smash4CharactersData: [CodableCharacter] = load("characters-\(Game.smash4.rawValue).json")
let ultimateCharactersData: [CodableCharacter] = load("characters-\(Game.ultimate.rawValue).json")

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
