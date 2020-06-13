//
//  CharacterAttributesRow.swift
//  SuperSmashBrosStats
//
//  Created by Kamaal Farah on 13/06/2020.
//  Copyright © 2020 Kamaal. All rights reserved.
//

import SwiftUI

struct CharacterAttributesRow: View {
    var stats: CodableCharacterAttributes

    var body: some View {
        NavigationLink(destination: Text(stats.name)) {
            HStack {
                Text(stats.name)
                    .font(.body)
                    .foregroundColor(.accentColor)
                Text(stats.values.last?.value ?? "")
                    .font(.body)
            }
        }
    }
}

//struct CharacterAttributesRow_Previews: PreviewProvider {
//    static var previews: some View {
//        CharacterAttributesRow()
//    }
//}
