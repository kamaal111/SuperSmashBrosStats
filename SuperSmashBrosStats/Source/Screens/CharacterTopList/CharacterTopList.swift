//
//  CharacterTopList.swift
//  SuperSmashBrosStats
//
//  Created by Kamaal Farah on 14/06/2020.
//  Copyright © 2020 Kamaal. All rights reserved.
//

import SwiftUI

struct CharacterTopList: View {
    @ObservedObject
    private var viewModel: CharacterTopListViewModel

    let attribute: CodableCharacterAttributes

    private let topLister = TopLister.shared

    init(attribute: CodableCharacterAttributes, game: Game) {
        self.attribute = attribute
        self.viewModel = CharacterTopListViewModel(attributes: attribute, game: game)
    }

    var body: some View {
        List {
            ForEach(self.viewModel.topListItems.keys.sorted(), id: \.self) { key in
                CharacterAttributeSection(
                    topListItems: self.viewModel.topListItems,
                    key: key,
                    attributeOwner: self.attribute.owner)
            }
        }
        .onAppear(perform: self.onCharacterTopListAppear)
        .actionSheet(isPresented: self.$viewModel.showSortActionSheet, content: self.sortAttributesByActionSheet)
        .navigationBarTitle(Text(self.attribute.name), displayMode: .inline)
        .navigationBarItems(trailing: Button(action: self.viewModel.sortButtonAction) {
            Image(systemName: "arrow.up.arrow.down")
        })
    }

    private func onCharacterTopListAppear() {
        self.viewModel.populateTopListItems()
    }

    private func sortAttributesByActionSheet() -> ActionSheet {
        return ActionSheet(title: Text("Sort Attributes By"), buttons: [
            .default(Text("Descending"), action: {
                self.viewModel.setSortingMethod(to: .descending)
            }),
            .default(Text("Ascending"), action: {
                self.viewModel.setSortingMethod(to: .ascending)
            }),
            .cancel()
        ])
    }
}

//struct CharacterTopList_Previews: PreviewProvider {
//    static var previews: some View {
//        CharacterTopList()
//    }
//}
