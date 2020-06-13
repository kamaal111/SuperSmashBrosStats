//
//  CharacterDetailScreenContentView.swift
//  SuperSmashBrosStats
//
//  Created by Kamaal Farah on 07/06/2020.
//  Copyright © 2020 Kamaal. All rights reserved.
//

import SwiftUI

struct CharacterDetailScreenContentView: View {
    @EnvironmentObject
    private var userData: UserDataModel

    @ObservedObject
    private var viewModel: CharacterDetailScreenViewModel

    var character: Character

    init(character: Character) {
        self.character = character
        self.viewModel = CharacterDetailScreenViewModel(character: character, kowalskiAnalysis: true)
    }

    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                self.backgroundColor
                UrlImageView(
                    imageUrl: self.character.details.mainImageUrl,
                    cachedDataImage: nil,
                    placeHolderColor: self.backgroundColor)
            }
            .frame(maxHeight: 200)
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Text(self.character.details.displayName)
                        .font(.title)
                        .padding(.leading, 24)
                    FavoriteButton(action: self.favoriteAction, color: self.favoritedStarColor)
                        .disabled(self.viewModel.settingFavorite)
                    Spacer()
                }
                .padding(.vertical, 8)
            }
            List {
                NavigationLink(destination: CharacterMovesScreenContentView(character: self.character)) {
                    Text("Character Moves")
                        .font(.body)
                        .foregroundColor(.accentColor)
                }
                Section(header: Text("Statistics").font(.headline)) {
                    ForEach(self.viewModel.uniqueAttributes) { (stats: CodableCharacterAttributes) in
                        CharacterAttributesRow(stats: stats)
                    }
                }
            }
            Spacer()
        }
        .onAppear(perform: self.onCharacterDetailScreenContentViewAppear)
        .navigationBarTitle(Text(self.character.details.displayName), displayMode: .inline)
    }

    private var backgroundColor: Color {
        let colorThemeRGB = self.character.details.colorThemeRGB
        return Color(red: colorThemeRGB.red / 255, green: colorThemeRGB.green / 255, blue: colorThemeRGB.blue / 255)
    }

    private var favoritedStarColor: Color {
        let characterDetails = self.character.details
        let isFavoriteColor = self.userData.favoritedStarColor(characterId: characterDetails.ownerId, game: characterDetails.game)
        return isFavoriteColor
    }

    private func favoriteAction() {
        self.viewModel.settingFavorite = true
        let characterDetails = self.character.details
        self.userData.editFavorites(characterId: characterDetails.ownerId, game: characterDetails.game)
        self.viewModel.settingFavorite = false
    }

    private func onCharacterDetailScreenContentViewAppear() {
        self.viewModel.populateCharacterAttributes()
    }
}

struct CharacterDetailScreenContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CharacterDetailScreenContentView(character: Character(id: "bla", details: ultimateCharactersData[0]))
        }
    }
}
