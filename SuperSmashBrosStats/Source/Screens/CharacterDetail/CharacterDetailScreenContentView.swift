//
//  CharacterDetailScreenContentView.swift
//  SuperSmashBrosStats
//
//  Created by Kamaal Farah on 07/06/2020.
//  Copyright © 2020 Kamaal. All rights reserved.
//

import SwiftUI

struct CharacterDetailScreenContentView: View {
    @ObservedObject
    private var viewModel = CharacterDetailScreenViewModel(kowalskiAnalysis: false)

    @State private var favorited = false

    var character: Character

    var body: some View {
        VStack {
            ZStack {
                backgroundColor
                UrlImageView(
                    imageUrl: self.character.details.mainImageUrl,
                    cachedDataImage: nil,
                    placeHolderColor: backgroundColor)
            }
            .frame(height: 200)
            VStack(alignment: .leading) {
                HStack {
                    Text(self.character.details.displayName)
                        .font(.title)
                        .padding(.leading, 24)
                    FavoriteButton(action: self.favoriteAction, color: self.favoritedStarColor)
                    Spacer()
                }
            }
            Form {
                ForEach(self.categories.keys.sorted(), id: \.self) { key in
                    MovesSection(characterMoves: self.categories[key] ?? [])
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
    
    private var categories: [String: [CodableCharacterMoves]] {
        let characterMoves = self.viewModel.characterMoves
        return Dictionary(grouping: characterMoves, by: { $0.moveType.rawValue })
    }

    private var favoritedStarColor: Color {
        if self.favorited { return .yellow }
        return .gray
    }

    private func favoriteAction() {
        self.favorited.toggle()
    }

    private func onCharacterDetailScreenContentViewAppear() {
        self.viewModel.populateCharacterMoves(of: self.character.details.ownerId)
    }
}

struct CharacterDetailScreenContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CharacterDetailScreenContentView(character: Character(id: "bla", details: ultimateCharactersData[0]))
        }
    }
}
