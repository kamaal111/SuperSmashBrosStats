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
    var isFavorited: Bool

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
}
