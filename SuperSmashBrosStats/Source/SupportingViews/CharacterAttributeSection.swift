//
//  CharacterAttributeSection.swift
//  SuperSmashBrosStats
//
//  Created by Kamaal Farah on 16/06/2020.
//  Copyright © 2020 Kamaal. All rights reserved.
//

import SwiftUI

struct CharacterAttributeSection: View {
    let topListItems: [String: [TopListItem]]
    let key: String
    let attributeOwner: String

    var body: some View {
        Section(header: Text(self.key).font(.headline)) {
            ForEach(self.topListItems[self.key] ?? [], id: \.self) { (item: TopListItem) in
                CharacterAttributeSectionItem(
                    itemOwner: item.owner,
                    itemValue: item.value,
                    attributeOwner: self.attributeOwner)
            }
        }
    }
}

struct CharacterAttributeSectionItem: View {
    let itemOwner: String
    let itemValue: String
    let attributeOwner: String

    var body: some View {
        HStack {
            Text(self.itemOwner)
                .foregroundColor(self.ownerTextColor)
            Spacer()
            Text(self.itemValue)
                .bold()
        }
    }

    private var ownerTextColor: Color {
        if self.attributeOwner != self.itemOwner { return .primary }
        return .accentColor
    }
}

//struct CharacterAttributeSection_Previews: PreviewProvider {
//    static var previews: some View {
//        CharacterAttributeSection()
//    }
//}
