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
        NavigationLink(destination: Text(self.stats.name)) {
            VStack(alignment: .leading) {
                Text(self.stats.name)
                    .font(.body)
                    .foregroundColor(.accentColor)
                ForEach(self.firstThreeValues, id: \.self) { (value: CodableCharacterAttributes.Values) in
                    HStack {
                        Text("\(value.name.capitalized):")
                            .font(.body)
                        Text(value.value)
                            .font(.body)
                    }
                }
            }
        }
    }

    var firstThreeValues: ArraySlice<CodableCharacterAttributes.Values> {
        let values = self.stats.values
        let length = values.count
        let limit = 3
        if length < limit {
            return values[0..<length]
        }
        return values[0..<limit]
    }
}

//struct CharacterAttributesRow_Previews: PreviewProvider {
//    static var previews: some View {
//        CharacterAttributesRow()
//    }
//}
