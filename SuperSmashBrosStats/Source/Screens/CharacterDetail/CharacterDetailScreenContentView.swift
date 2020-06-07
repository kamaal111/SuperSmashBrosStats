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
        ZStack {
            backgroundColor
            Text(character.character.displayName)
        }
        .navigationBarTitle(Text(character.character.displayName), displayMode: .inline)
    }

    private var backgroundColor: Color {
        let colorThemeRGB = character.character.colorThemeRGB
        return Color(red: colorThemeRGB.red / 255, green: colorThemeRGB.green / 255, blue: colorThemeRGB.blue / 255)
    }
}
