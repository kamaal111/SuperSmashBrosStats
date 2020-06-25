//
//  CharacterTopListViewModel.swift
//  SuperSmashBrosStats
//
//  Created by Kamaal Farah on 16/06/2020.
//  Copyright © 2020 Kamaal. All rights reserved.
//

import Combine

final class CharacterTopListViewModel: ObservableObject {
    @Published var topListItems = [String: [TopListItem]]()
    @Published var showSortActionSheet = false

    let attributes: CodableCharacterAttributes
    var game: Game

    private let topLister = TopLister.shared

    init(attributes: CodableCharacterAttributes, game: Game) {
        self.attributes = attributes
        self.game = game
    }

    func populateTopListItems() {
        self.topListItems = self.topLister.getTopListItems(of: self.attributes.name, game: self.game.rawValue)
    }

    func setSortingMethod(to sortingMethod: SortListMethod) {
        self.topLister.setSortingMethod(to: sortingMethod)
        self.topListItems = self.topLister.getTopListItems(of: self.attributes.name, game: self.game.rawValue)
    }

    func sortButtonAction() {
        self.showSortActionSheet = true
    }
}
