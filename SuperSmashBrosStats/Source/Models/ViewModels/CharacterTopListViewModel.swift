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

    private let topLister = TopLister.shared

    init(attributes: CodableCharacterAttributes) {
        self.attributes = attributes
    }

    func populateTopListItems() {
        self.topListItems = self.topLister.getTopListItems(of: self.attributes.name, game: Game.ultimate.rawValue)
    }

    func setSortingMethod(to sortingMethod: SortListMethod) {
        self.topLister.setSortingMethod(to: sortingMethod)
        self.topListItems = self.topLister.getTopListItems(of: self.attributes.name, game: Game.ultimate.rawValue)
    }

    func sortButtonAction() {
        self.showSortActionSheet = true
    }
}
