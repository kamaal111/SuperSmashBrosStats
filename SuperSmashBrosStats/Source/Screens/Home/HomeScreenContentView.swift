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
                TextField("Search:", text: self.$viewModel.searchBarText)
                Section(header: Text("Characters").font(.headline)) {
                    if self.viewModel.loadingCharacters {
                        Text("Loading...")
                            .bold()
                    } else if self.shouldShowNoFavoriteText {
                        Text("No characters in your favorites list")
                            .bold()
                    } else if self.filteredCharacters.isEmpty {
                        Text("No characters found with the name \(self.viewModel.searchBarText)")
                            .bold()
                    } else {
                        ForEach(self.filteredCharacters) { (character: Character) in
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
            }
        }
        .onAppear(perform: self.onHomeScreenContentViewAppear)
        .navigationBarTitle(Text("SSBU Roster"))
    }

    private var shouldShowNoFavoriteText: Bool {
        return self.viewModel.showFavoritesOnly && self.filteredCharacters.isEmpty
    }

    private var filteredCharacters: [Character] {
        return self.viewModel.filteredCharacters(favoritedCharacters: self.userData.favoritedCharacters)
    }

    private func onHomeScreenContentViewAppear() {
        do {
            let cachedImages = try self.coreDataManager.fetch(CachedImage.self)
            self.viewModel.populateCharacters(cachedImages: cachedImages!)
        } catch {
            print("Could not retrieve chached images from core data", error)
        }
    }
}
