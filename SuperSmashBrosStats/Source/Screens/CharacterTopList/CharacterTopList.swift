//
//  CharacterTopList.swift
//  SuperSmashBrosStats
//
//  Created by Kamaal Farah on 14/06/2020.
//  Copyright © 2020 Kamaal. All rights reserved.
//

import SwiftUI

struct CharacterTopList: View {
    @State private var topListItems = [TopListItem]()

    var attribute: CodableCharacterAttributes

    private let topLister = TopLister.shared

    var body: some View {
        List {
            ForEach(self.categorizedTopList.keys.sorted(), id: \.self) { key in
                Section(header: Text(key).font(.headline)) {
                    ForEach(self.categorizedTopList[key]!, id: \.self) { (item: TopListItem) in
                        HStack {
                            Text(item.owner)
                            Text(item.value)
                        }
                    }
                }
            }
        }
        .onAppear(perform: {
            let topListItems = self.topLister.getTopListItems(of: self.attribute.name, game: Game.ultimate.rawValue)
            self.topListItems = topListItems
        })
    }

    private var categorizedTopList: [String: [TopListItem]] {
        return Dictionary(grouping: self.topListItems, by: { (item: TopListItem) in
            item.valueName
        })
    }
}

//struct CharacterTopList_Previews: PreviewProvider {
//    static var previews: some View {
//        CharacterTopList()
//    }
//}
