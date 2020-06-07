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
        List {
            if !viewModel.characters.isEmpty {
                ForEach(viewModel.characters) { character in
                    CharacterRow(characterWithImage: character)
                }
            } else {
                Text("Loading...")
            }
        }
        .onAppear(perform: self.onHomeScreenContentViewAppear)
    }

    private func onHomeScreenContentViewAppear() {
        let cachedImages = try? self.coreDataManager.fetch(CachedImage.self)
        self.viewModel.populateCharacters(cachedImages: cachedImages)
    }
}
