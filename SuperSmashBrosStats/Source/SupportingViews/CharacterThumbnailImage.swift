//
//  CharacterThumbnailImage.swift
//  SuperSmashBrosStats
//
//  Created by Kamaal Farah on 08/06/2020.
//  Copyright © 2020 Kamaal. All rights reserved.
//

import SwiftUI

struct CharacterThumbnailImage: View {
    var character: Character

    var body: some View {
        ZStack {
            Circle()
                .frame(width: 48, height: 48)
                .foregroundColor(colorTheme)
            UrlImageView(
                imageUrl: character.character.thumbnailUrl,
                cachedDataImage: character.cachedThumbnailUrl,
                placeHolderColor: .gray)
                .scaledToFit()
                .frame(width: 48, height: 48)
                .clipShape(Circle())
        }
    }

    private var colorTheme: Color {
        return Color(
            red: character.character.colorThemeRGB.red / 255,
            green: character.character.colorThemeRGB.green / 255,
            blue: character.character.colorThemeRGB.blue / 255)
    }
}

struct CharacterThumbnailImage_Previews: PreviewProvider {
    static var previews: some View {
        CharacterThumbnailImage(character: Character(
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
            .previewLayout(.sizeThatFits)
    }
}
