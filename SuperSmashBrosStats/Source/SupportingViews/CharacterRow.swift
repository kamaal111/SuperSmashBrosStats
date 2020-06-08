//
//  CharacterRow.swift
//  SuperSmashBrosStats
//
//  Created by Kamaal Farah on 06/06/2020.
//  Copyright © 2020 Kamaal. All rights reserved.
//

import SwiftUI

struct CharacterRow: View {
    var characterWithImage: Character

    var body: some View {
        HStack {
            ZStack {
                Circle()
                    .frame(width: 48, height: 48)
                    .foregroundColor(colorTheme)
                UrlImageView(
                    imageUrl: characterWithImage.character.thumbnailUrl,
                    cachedDataImage: characterWithImage.cachedThumbnailUrl)
                    .scaledToFit()
                    .frame(width: 48, height: 48)
                    .clipShape(Circle())
            }
            
            Text(characterWithImage.character.displayName)
                .font(.headline)
        }
    }

    private var colorTheme: Color {
        return Color(
            red: characterWithImage.character.colorThemeRGB.red / 255,
            green: characterWithImage.character.colorThemeRGB.green / 255,
            blue: characterWithImage.character.colorThemeRGB.blue / 255)
    }
}
