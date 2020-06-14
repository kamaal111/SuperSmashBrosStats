//
//  TopLister.swift
//  SuperSmashBrosStats
//
//  Created by Kamaal Farah on 14/06/2020.
//  Copyright © 2020 Kamaal. All rights reserved.
//

import Foundation

class TopLister {

    private var topListFiles = [String: [TopListFile]]()
    private var topListItems = [String: [TopListItem]]()

    private let responderHolder = ResponderHolder.shared

    private init() {
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        items.forEach {
            if $0.hasPrefix("characterAttributes-") {
                let splittedTextFileName = $0.split(separator: "-")
                let game = String(splittedTextFileName[1])
                let characterId = Int(splittedTextFileName[2].split(separator: ".")[0])
                if self.topListFiles[game] == nil { self.topListFiles[game] = [] }
                if let unwrappedCharacterId = characterId {
                    self.topListFiles[game]?.append(TopListFile(fileName: $0, game: game, characterId: unwrappedCharacterId))
                }
            }
        }
    }

    static let shared = TopLister()

    func getTopListItems(of attribute: String, game: String) -> [TopListItem] {
        guard let filesList = self.topListFiles[game] else { return [] }
        guard self.topListItems[attribute] == nil else { return self.topListItems[attribute]! }
        for file in filesList {
            let characterId = file.characterId
            if let game = Game(rawValue: file.game) {
                if let characterAttributes = self.responderHolder.getCharacterAttributes(game: game, characterId: characterId) {
                    for attributes in characterAttributes where attributes.name == attribute {
                        let ownerName = attributes.owner
                        if self.topListItems[attribute] == nil { self.topListItems[attribute] = [] }
                        attributes.values.forEach { value in
                            let topListItem = TopListItem(owner: ownerName, valueName: value.name, value: value.value)
                            self.topListItems[attribute]?.append(topListItem)
                        }
                    }
                } else {
                    let characterAttributes: [CodableCharacterAttributes] = load("characterAttributes-\(game)-\(characterId).json")
                    self.responderHolder.setCharacterAttributes(game: game, characterId: characterId, characterAttributes: characterAttributes)
                    for attributes in characterAttributes where attributes.name == attribute {
                        let ownerName = attributes.owner
                        if self.topListItems[attribute] == nil { self.topListItems[attribute] = [] }
                        attributes.values.forEach { value in
                            let topListItem = TopListItem(owner: ownerName, valueName: value.name, value: value.value)
                            self.topListItems[attribute]?.append(topListItem)
                        }
                    }
                }
            }
        }
        return self.topListItems[attribute] ?? []
    }

}

struct TopListItem: Hashable {
    let owner: String
    let valueName: String
    let value: String
}

struct TopListFile {
    let fileName: String
    let game: String
    let characterId: Int
}
