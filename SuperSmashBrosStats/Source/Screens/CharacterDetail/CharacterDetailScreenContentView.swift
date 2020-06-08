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

    var character: Character

    var body: some View {
        VStack {
            backgroundColor
                .frame(height: 200)
            Text(character.character.displayName)
            Spacer()
        }
        .navigationBarTitle(Text(character.character.displayName), displayMode: .inline)
    }

    private var backgroundColor: Color {
        let colorThemeRGB = character.character.colorThemeRGB
        return Color(red: colorThemeRGB.red / 255, green: colorThemeRGB.green / 255, blue: colorThemeRGB.blue / 255)
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
