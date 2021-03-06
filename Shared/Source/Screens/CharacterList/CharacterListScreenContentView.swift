//
//  CharacterListScreen.swift
//  SuperSmashBrosStats
//
//  Created by Kamaal Farah on 20/06/2020.
//  Copyright © 2020 Kamaal. All rights reserved.
//

import SwiftUI

struct CharacterListScreenContentView: View {
    @EnvironmentObject
    private var userData: UserDataModel

    @ObservedObject
    var viewModel: CharacterListScreenViewModel

    var game: Game

    init(game: Game) {
        self.viewModel = CharacterListScreenViewModel(game: game)
        self.game = game
        guard let cachedImages = try? self.coreDataManager.fetch(CachedImage.self) else { return }
        self.viewModel.populateCharacters(cachedImages: cachedImages)
    }

    private let coreDataManager = CoreDataManager.shared

    var body: some View {
        List {
            Toggle(isOn: self.$viewModel.showFavoritesOnly) {
                Text(localized: .FAVORITES_ONLY)
                    .font(.body)
            }
            TextField("\(Localizer.getLocalizableString(of: .SEARCH)):", text: self.$viewModel.searchBarText)
            Section(header: Text(localized: .CHARACTERS).font(.headline)) {
                if self.viewModel.loadingCharacters {
                    Text("\(Localizer.getLocalizableString(of: .LOADING))...")
                        .bold()
                } else if self.shouldShowNoFavoriteText {
                    Text(localized: .NO_CHARACTERS_IN_FAVORITES)
                        .bold()
                } else if self.filteredCharacters.isEmpty {
                    Text(Localizer.getLocalizableString(
                        of: .NO_CHARACTERS_WITH_NAME,
                        with: [self.viewModel.searchBarText]))
                        .bold()
                } else {
                    ForEach(self.filteredCharacters) { (character: Character) in
                        NavigationLink(destination: CharacterDetailScreenContentView(
                            character: character,
                            game: self.game)) {
                                CharacterRow(characterWithImage: character)
                            }
                    }
                }
            }
        }
        .onAppear(perform: self.onCharacterListContentViewAppear)
        .onDisappear(perform: self.onCharacterListContentViewDisappear)
        .navigationBarTitle(Text(self.titleText), displayMode: .inline)
    }

    private var shouldShowNoFavoriteText: Bool {
        return self.viewModel.showFavoritesOnly && self.filteredCharacters.isEmpty
    }

    private var filteredCharacters: [Character] {
        return self.viewModel.filteredCharacters(favoritedCharacters: self.userData.favoritedCharacters)
    }

    private var titleText: String {
        switch self.game {
        case .smash4:
            return Localizer.getLocalizableString(of: .SMASH_4_ROSTER)
        case .ultimate:
            return Localizer.getLocalizableString(of: .SMASH_ULTIMATE_ROSTER)
        }
    }

    private func onCharacterListContentViewAppear() { }

    private func onCharacterListContentViewDisappear() { }
}

//struct CharacterListScreenContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        CharacterListScreenContentView()
//    }
//}
