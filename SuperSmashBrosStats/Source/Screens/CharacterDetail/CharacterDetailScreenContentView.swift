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
}

struct CharacterDetailScreenContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CharacterDetailScreenContentView(character: Character(
                id: "93e73d42db7d46ee909cb5c427b11f61",
                character: CodableCharacter(
                    colorTheme: "A5D160",
                    displayName: "Young Link",
                    name: "YoungLink",
                    id: "93e73d42db7d46ee909cb5c427b11f61",
                    ownerId: 79,
                    fullUrl: "https://kuroganehammer.com/Ultimate/Young%20Link",
                    mainImageUrl: "https://kuroganehammer.comhttp://kuroganehammer.com/Ultimate/logo2/Young Link.png",
                    thumbnailUrl: "https://kuroganehammer.com/images/ultimate/character/young_link.png",
                    game: "Ultimate",
                    related: CodableRelated(ultimate: nil, smash4: nil))))
        }
    }
}
