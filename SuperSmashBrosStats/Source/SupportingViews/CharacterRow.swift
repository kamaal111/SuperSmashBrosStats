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
            CharacterThumbnailImage(character: self.characterWithImage)
            Text(characterWithImage.character.displayName)
                .font(.headline)
        }
    }
}
