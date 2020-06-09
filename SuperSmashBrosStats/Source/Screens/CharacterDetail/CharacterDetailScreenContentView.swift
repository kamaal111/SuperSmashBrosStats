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
    private var viewModel = CharacterDetailScreenViewModel()

    @State private var favorited = false

    var character: Character

    var body: some View {
        VStack {
            ZStack {
                backgroundColor
                UrlImageView(
                    imageUrl: self.character.character.mainImageUrl,
                    cachedDataImage: nil,
                    placeHolderColor: backgroundColor)
            }
            .frame(height: 200)
            VStack(alignment: .leading) {
                HStack {
                    Text(self.character.character.displayName)
                        .font(.title)
                        .padding(.leading, 24)
                    Button(action: self.favoriteAction) {
                        Image(systemName: "star.fill")
                            .foregroundColor(self.favoritedStarColor)
                    }
                    Spacer()
                }
            }
            Spacer()
        }
        .onAppear(perform: self.onCharacterDetailScreenContentViewAppear)
        .navigationBarTitle(Text(self.character.character.displayName), displayMode: .inline)
    }

    private var backgroundColor: Color {
        let colorThemeRGB = self.character.character.colorThemeRGB
        return Color(red: colorThemeRGB.red / 255, green: colorThemeRGB.green / 255, blue: colorThemeRGB.blue / 255)
    }

    private var favoritedStarColor: Color {
        if self.favorited { return .yellow }
        return .gray
    }

    private func favoriteAction() {
        self.favorited.toggle()
    }

    private func onCharacterDetailScreenContentViewAppear() {
        self.viewModel.populateCharacterMoves(of: self.character.character.ownerId)
    }
}

struct CharacterDetailScreenContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CharacterDetailScreenContentView(character: Character(id: "bla", character: ultimateCharactersData[0]))
        }
    }
}
