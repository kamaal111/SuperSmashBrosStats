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
                .foregroundColor(self.colorTheme)
            UrlImageView(
                imageUrl: self.character.details.thumbnailUrl,
                cachedDataImage: self.character.cachedThumbnailUrl,
                placeHolderColor: .gray)
                .scaledToFit()
                .frame(width: 48, height: 48)
                .clipShape(Circle())
        }
    }

    private var colorTheme: Color {
        let rgb = self.character.details.colorThemeRGB
        return Color(red: rgb.red / 255, green: rgb.green / 255, blue: rgb.blue / 255)
    }
}

struct CharacterThumbnailImage_Previews: PreviewProvider {
    static var previews: some View {
        CharacterThumbnailImage(character: Character(
            id: "93e73d42db7d46ee909cb5c427b11f61",
            details: CodableCharacter(
            colorTheme: "A5D160",
                displayName: "Young Link",
                name: "YoungLink",
                id: "93e73d42db7d46ee909cb5c427b11f61",
                ownerId: 79,
                fullUrl: "https://kuroganehammer.com/Ultimate/Young%20Link",
                mainImageUrl: "https://kuroganehammer.comhttp://kuroganehammer.com/Ultimate/logo2/Young Link.png",
                thumbnailUrl: "https://kuroganehammer.com/images/ultimate/character/young_link.png",
                game: "Ultimate",
                related: CodableCharacter.CodableRelated(ultimate: nil, smash4: nil))))
            .previewLayout(.sizeThatFits)
    }
}
