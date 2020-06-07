//
//  HomeScreenContentView.swift
//  SuperSmashBrosStats
//
//  Created by Kamaal Farah on 06/06/2020.
//  Copyright © 2020 Kamaal. All rights reserved.
//

import SwiftUI

struct HomeScreenContentView: View {
    @ObservedObject
    var viewModel: HomeScreenViewModel

    private let coreDataManager = CoreDataManager.shared

    var body: some View {
        ZStack {
            List {
                ForEach(viewModel.characters) { character in
                    NavigationLink(destination: CharacterDetailScreenContentView(character: character)) {
                        CharacterRow(characterWithImage: character)
                    }
                }
            }
            if viewModel.characters.isEmpty {
                Text("Loading...")
            }
        }
        .onAppear(perform: self.onHomeScreenContentViewAppear)
        .navigationBarTitle(Text("SSBU Roster"))
    }

    private func onHomeScreenContentViewAppear() {
        if let cachedImages = try? self.coreDataManager.fetch(CachedImage.self) {
            self.viewModel.populateCharacters(cachedImages: cachedImages)
        }
    }
}
