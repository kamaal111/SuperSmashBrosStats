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

    var attribute: CodableCharacterAttributes

    private let topLister = TopLister.shared

    var body: some View {
        List {
            ForEach(self.topListItems.keys.sorted(), id: \.self) { key in
                Section(header: Text(key).font(.headline)) {
                    ForEach(self.topListItems[key]!.sorted(by: self.sortTopListBy(a:b:)), id: \.self) { (item: TopListItem) in
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
        .navigationBarTitle(Text(self.attribute.name), displayMode: .inline)
    }

    private func onCharacterTopListAppear() {
        let topListItems = self.topLister.getTopListItems(of: self.attribute.name, game: Game.ultimate.rawValue)
        self.topListItems = topListItems
    }

    private func sortTopListBy(a: TopListItem, b: TopListItem) -> Bool {
        switch a.valueType {
        case .normalNumber:
            guard let valueA = Double(a.value), let valueB = Double(b.value) else { return false }
            return  valueA > valueB
        case .percentage, .times:
            guard let valueA = Double(a.value.dropLast()), let valueB = Double(b.value.dropLast()) else { return false }
            return  valueA > valueB
        }
    }
}

//struct CharacterTopList_Previews: PreviewProvider {
//    static var previews: some View {
//        CharacterTopList()
//    }
//}
