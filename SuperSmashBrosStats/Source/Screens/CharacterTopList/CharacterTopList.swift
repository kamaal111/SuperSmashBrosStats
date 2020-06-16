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

    init(attribute: CodableCharacterAttributes) {
        self.attribute = attribute
        self.viewModel = CharacterTopListViewModel(attributes: attribute)
    }

    var body: some View {
        List {
            ForEach(self.viewModel.topListItems.keys.sorted(), id: \.self) { key in
                Section(header: Text(key).font(.headline)) {
                    ForEach(self.viewModel.topListItems[key] ?? [], id: \.self) { (item: TopListItem) in
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
            })
            ,
            .cancel()
        ])
    }
}

final class CharacterTopListViewModel: ObservableObject {
    @Published var topListItems = [String: [TopListItem]]()
    @Published var showSortActionSheet = false

    let attributes: CodableCharacterAttributes

    private let topLister = TopLister.shared

    init(attributes: CodableCharacterAttributes) {
        self.attributes = attributes
    }

    func populateTopListItems() {
        self.topListItems = self.topLister.getTopListItems(of: self.attributes.name, game: Game.ultimate.rawValue)
    }

    func setSortingMethod(to sortingMethod: SortListMethod) {
        self.topLister.setSortingMethod(to: sortingMethod)
        self.topListItems = self.topLister.getTopListItems(of: self.attributes.name, game: Game.ultimate.rawValue)
    }

    func sortButtonAction() {
        self.showSortActionSheet = true
    }
}

//struct CharacterTopList_Previews: PreviewProvider {
//    static var previews: some View {
//        CharacterTopList()
//    }
//}
