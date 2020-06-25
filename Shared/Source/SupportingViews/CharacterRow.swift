//
//  CharacterRow.swift
//  SuperSmashBrosStats
//
//  Created by Kamaal Farah on 06/06/2020.
//  Copyright © 2020 Kamaal. All rights reserved.
//

import SwiftUI

struct CharacterRow: View {
    @EnvironmentObject
    private var userData: UserDataModel

    var characterWithImage: Character

    var body: some View {
        HStack {
            CharacterThumbnailImage(character: self.characterWithImage)
            Text(self.characterWithImage.details.displayName)
                .font(.headline)
            Spacer()
            Image(systemName: "star.fill")
                .foregroundColor(self.isFavorited ? .yellow : .gray)
        }
    }

    private var isFavorited: Bool {
        return self.userData.checkIfCharacterIsFavorite(
            characterId: characterWithImage.details.ownerId,
            game: characterWithImage.details.game)
    }
}
