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
    private var sortMethod: SortListMethod = .descending

    private let responderHolder = ResponderHolder.shared

    private init() {
        let path = Bundle.main.resourcePath!
        let items = try! FileManager.default.contentsOfDirectory(atPath: path)
        items.forEach {
            if $0.hasPrefix("characterAttributes-") {
                let splittedTextFileName = $0.split(separator: "-")
                let game = String(splittedTextFileName[1])
                if self.topListFiles[game] == nil { self.topListFiles[game] = [] }
                let characterId = Int(splittedTextFileName[2].split(separator: ".")[0])
                if let unwrappedCharacterId = characterId {
                    self.topListFiles[game]?.append(TopListFile(fileName: $0, game: game, characterId: unwrappedCharacterId))
                }
            }
        }
    }

    static var shared = TopLister()

    func resetData() {
        self.topListItems = [:]
        self.sortMethod = .descending
    }

    func getTopListItems(of attribute: String, game: String) -> [String: [TopListItem]] {
        guard let filesList = self.topListFiles[game] else { return [:] }
        if let topListItems = self.topListItems[attribute] { return self.categorizeTopList(topList: topListItems) }
        filesList.forEach { file in
            let characterId = file.characterId
            if let game = Game(rawValue: file.game) {
                if let characterAttributes = self.responderHolder.getCharacterAttributes(game: game, characterId: characterId) {
                    self.setTopList(characterAttributes: characterAttributes, attribute: attribute)
                } else {
                    let characterAttributes: [CodableCharacterAttributes] = load("characterAttributes-\(game)-\(characterId).json")
                    self.responderHolder.setCharacterAttributes(game: game, characterId: characterId, characterAttributes: characterAttributes)
                    self.setTopList(characterAttributes: characterAttributes, attribute: attribute)
                }
            }
        }
        return self.categorizeTopList(topList: self.topListItems[attribute] ?? [])
    }

    func setSortingMethod(to sortingMethod: SortListMethod) {
        self.sortMethod = sortingMethod
    }

    func getSortingMethod() -> SortListMethod {
        return self.sortMethod
    }

    private func categorizeTopList(topList: [TopListItem]) -> [String: [TopListItem]] {
        let categorizedTopList = Dictionary(grouping: topList) { $0.valueName }
            .mapValues { $0.sorted(by: self.sortTopListBy(a:b:)) }
        return categorizedTopList
    }

    private func sortTopListBy(a: TopListItem, b: TopListItem) -> Bool {
        switch a.valueType {
        case .normalNumber:
            guard let valueA = Double(a.value), let valueB = Double(b.value) else { return false }
            return self.compareForSort(a: valueA, b: valueB)
        case .percentage, .times:
            guard let valueA = Double(a.value.dropLast()), let valueB = Double(b.value.dropLast()) else { return false }
            return self.compareForSort(a: valueA, b: valueB)
        }
    }

    private func compareForSort(a: Double, b: Double) -> Bool {
        switch self.sortMethod {
        case .descending:
            return a > b
        case .ascending:
            return a < b
        case .defaultSort:
            return false
        }
    }

    private func setTopList(characterAttributes: [CodableCharacterAttributes], attribute: String) {
        var uniqueAttributeNames = [String]()
        for attributes in characterAttributes where attributes.name == attribute && !uniqueAttributeNames.contains(attributes.name) {
            let ownerName = attributes.owner
            if self.topListItems[attribute] == nil { self.topListItems[attribute] = [] }
            for value in attributes.values where !value.value.isEmpty {
                var valueType: TopListItemValueType = .normalNumber
                if value.value.hasSuffix("x") { valueType = .times }
                else if value.value.hasSuffix("%") { valueType = .percentage }
                let topListItem = TopListItem(
                    owner: ownerName,
                    valueName: value.name,
                    value: value.value,
                    valueType: valueType)
                self.topListItems[attribute]?.append(topListItem)
                uniqueAttributeNames.append(attributes.name)
            }
        }
    }

}

enum TopListItemValueType {
    case normalNumber
    case percentage
    case times
}

enum SortListMethod {
    case descending
    case ascending
    case defaultSort
}

struct TopListItem: Hashable {
    let owner: String
    let valueName: String
    let value: String
    let valueType: TopListItemValueType
}

struct TopListFile {
    let fileName: String
    let game: String
    let characterId: Int
}
