//
//  SettingsScreenContentView.swift
//  SuperSmashBrosStats
//
//  Created by Kamaal Farah on 21/06/2020.
//  Copyright © 2020 Kamaal. All rights reserved.
//

import SwiftUI

struct SettingsScreenContentView: View {
    @EnvironmentObject
    private var userData: UserDataModel

    var body: some View {
        VStack {
            ForEach(self.userData.favoritedCharacters, id: \.self) { (character: FavoritedCharacter) in
                Text("\(character.characterId) \(character.game)")
            }
        }
    }
}

//struct SettingsScreenContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        SettingsScreenContentView()
//    }
//}
