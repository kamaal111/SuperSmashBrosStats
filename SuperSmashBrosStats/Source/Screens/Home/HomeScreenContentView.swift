//
//  HomeScreenContentView.swift
//  SuperSmashBrosStats
//
//  Created by Kamaal Farah on 06/06/2020.
//  Copyright © 2020 Kamaal. All rights reserved.
//

import SwiftUI

struct HomeScreenContentView: View {
    @EnvironmentObject
    private var userData: UserDataModel

    @ObservedObject
    var viewModel: HomeScreenViewModel

    private let coreDataManager = CoreDataManager.shared

    var body: some View {
        ZStack {
            List {
                Toggle(isOn: self.$viewModel.showFavoritesOnly) {
                    Text("Favorites Only")
                        .font(.body)
                }
                Section(header: Text("Characters").font(.headline)) {
                    ForEach(self.viewModel.filteredCharacters(favoritedCharacters: self.userData.favoritedCharacters)) { (character: Character) in
                        NavigationLink(destination: CharacterDetailScreenContentView(character: character)) {
                            CharacterRow(
                                characterWithImage: character,
                                isFavorited: self.userData.checkIfCharacterIsFavorite(
                                    characterId: character.details.ownerId,
                                    game: character.details.game))
                        }
                    }
                }
            }
            if self.viewModel.characters.isEmpty {
                Text("Loading...")
            }
        }
        .onAppear(perform: self.onHomeScreenContentViewAppear)
        .navigationBarTitle(Text("SSBU Roster"))
    }

    private func onHomeScreenContentViewAppear() {
        do {
            let cachedImages = try self.coreDataManager.fetch(CachedImage.self)
            self.viewModel.populateCharacters(cachedImages: cachedImages!)
        } catch {
            fatalError("Could not retrieve chached images from core data \(error)")
        }
    }
}
