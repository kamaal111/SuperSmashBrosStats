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

    init(character: Character) {
        self.character = character
        self.viewModel = CharacterMovesScreenViewModel(character: character)
    }
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
                }
            }
            List {
                ForEach(self.viewModel.categorizedCharacterMoves.keys.sorted(), id: \.self) { key in
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
        return Color(red: colorThemeRGB.red / 255, green: colorThemeRGB.green / 255, blue: colorThemeRGB.blue / 255)
    }

    private func onCharacterMovesScreenContentViewAppear() {
        self.viewModel.populateCharacterMoves()
    }
}

struct CharacterMovesScreenContentView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterMovesScreenContentView(character: Character(id: "bla", details: ultimateCharactersData[0]))
    }
}
