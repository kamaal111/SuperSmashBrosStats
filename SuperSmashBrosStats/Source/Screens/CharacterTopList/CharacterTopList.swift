//
//  CharacterTopList.swift
//  SuperSmashBrosStats
//
//  Created by Kamaal Farah on 14/06/2020.
//  Copyright © 2020 Kamaal. All rights reserved.
//

import SwiftUI

struct CharacterTopList: View {
    @State private var topListItems = [String: [TopListItem]]()
    @State private var showSortActionSheet = false

    let attribute: CodableCharacterAttributes

    private let topLister = TopLister.shared

    init(attribute: CodableCharacterAttributes) {
        self.attribute = attribute
    }

    var body: some View {
        List {
            ForEach(self.topListItems.keys.sorted(), id: \.self) { key in
                Section(header: Text(key).font(.headline)) {
                    ForEach(self.topListItems[key]!, id: \.self) { (item: TopListItem) in
                        HStack {
                            Text(item.owner)
                                .foregroundColor(self.attribute.owner == item.owner ? .accentColor : .primary)
                            Text(item.value)
                        }
                    }
                }
            }
        }
        .onAppear(perform: self.onCharacterTopListAppear)
        .actionSheet(isPresented: self.$showSortActionSheet, content: {
            ActionSheet(title: Text("Sort Attributes By"), buttons: [
                .default(Text("Descending"), action: {
                    self.topLister.setSortingMethod(to: .descending)
                    self.topListItems = self.topLister.getTopListItems(of: self.attribute.name, game: Game.ultimate.rawValue)
                }),
                .default(Text("Ascending"), action: {
                    self.topLister.setSortingMethod(to: .ascending)
                    self.topListItems = self.topLister.getTopListItems(of: self.attribute.name, game: Game.ultimate.rawValue)
                })
                ,
                .cancel()
            ])
        })
        .navigationBarTitle(Text(self.attribute.name), displayMode: .inline)
        .navigationBarItems(trailing: Button(action: {
            self.showSortActionSheet = true
        }) {
            Image(systemName: "arrow.up.arrow.down")
        })
    }

    private func onCharacterTopListAppear() {
        self.topListItems = self.topLister.getTopListItems(of: self.attribute.name, game: Game.ultimate.rawValue)
    }
}

//struct CharacterTopList_Previews: PreviewProvider {
//    static var previews: some View {
//        CharacterTopList()
//    }
//}
