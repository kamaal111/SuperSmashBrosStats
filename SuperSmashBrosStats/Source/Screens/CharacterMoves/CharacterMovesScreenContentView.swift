//
//  CharacterMovesScreenContentView.swift
//  SuperSmashBrosStats
//
//  Created by Kamaal Farah on 12/06/2020.
//  Copyright © 2020 Kamaal. All rights reserved.
//

import SwiftUI

struct CharacterMovesScreenContentView: View {
    @ObservedObject
    private var viewModel: CharacterMovesScreenViewModel

    var character: Character

    init(character: Character, game: Game) {
        self.character = character
        self.viewModel = CharacterMovesScreenViewModel(character: character, game: game, kowalskiAnalysis: true)
    }
    var body: some View {
        VStack {
            ZStack {
                self.backgroundColor
                UrlImageView(
                    imageUrl: self.character.details.thumbnailUrl,
                    cachedDataImage: self.character.cachedThumbnailUrl,
                    placeHolderColor: self.backgroundColor)
            }
            .frame(height: 200)
            VStack(alignment: .leading) {
                HStack {
                    Text(self.character.details.displayName)
                        .font(.title)
                        .padding(.leading, 24)
                }
            }
            List {
                ForEach(self.sortedCategoryKeys, id: \.self) { key in
                    MovesSection(characterMoves: self.viewModel.categorizedCharacterMoves[key] ?? [])
                }
            }
            Spacer()
        }
        .onAppear(perform: self.onCharacterMovesScreenContentViewAppear)
        .navigationBarTitle(Text(self.character.details.displayName), displayMode: .inline)
    }

    private var backgroundColor: Color {
        let colorThemeRGB = self.character.details.colorThemeRGB
        return colorThemeRGB
    }

    private var sortedCategoryKeys: [String] {
        self.viewModel.categorizedCharacterMoves.keys.sorted()
    }

    private func onCharacterMovesScreenContentViewAppear() {
        self.viewModel.populateCharacterMoves()
    }
}

struct CharacterMovesScreenContentView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterMovesScreenContentView(
            character: Character(id: "bla", details: ultimateCharactersData[0]),
            game: .ultimate)
    }
}
