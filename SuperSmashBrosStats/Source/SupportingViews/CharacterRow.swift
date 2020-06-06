//
//  CharacterRow.swift
//  SuperSmashBrosStats
//
//  Created by Kamaal Farah on 06/06/2020.
//  Copyright © 2020 Kamaal. All rights reserved.
//

import SwiftUI

struct CharacterRow: View {
    var character: Character

    var body: some View {
        HStack(spacing: 0) {
            Text(character.displayName)
        }
        .listRowBackground(colorTheme)
    }

    private var colorTheme: Color {
        return Color(
            red: character.colorThemeRGB.red / 255,
            green: character.colorThemeRGB.green / 255,
            blue: character.colorThemeRGB.blue / 255)
    }
}

struct CharacterRow_Previews: PreviewProvider {
    static var previews: some View {
        List {
            CharacterRow(character: Character(
                colorTheme: "#A79FE5",
                displayName: "Bayonetta",
                id: "950946fe358646498030139a7612afd2",
                ownerId: 1,
                fullUrl: "https://kuroganehammer.com/Smash4/Bayonetta",
                mainImageUrl: "https://kuroganehammer.com/images/smash4/logo2/Bayonetta.png",
                thumbnailUrl: "https://kuroganehammer.com/images/smash4/character/character-bayonetta3.png",
                game: "smash4",
                related: Character.Related(
                    ultimate: Character.Related.Ultimate(
                        itSelf: "http://api.kuroganehammer.com/api/characters/name/Bayonetta?game=ultimate",
                        moves: "http://api.kuroganehammer.com/api/characters/name/Bayonetta/moves?game=ultimate"))))
        }
        .previewLayout(.sizeThatFits)
    }
}
