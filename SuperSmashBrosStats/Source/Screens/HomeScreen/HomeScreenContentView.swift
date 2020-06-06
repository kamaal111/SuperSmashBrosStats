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

    var body: some View {
        List {
            if !viewModel.characters.isEmpty {
                ForEach(viewModel.characters) { character in
                    CharacterRow(character: character)
                }
            } else {
                Text("Loading...")
            }
        }
    }
}

struct HomeScreenContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenContentView(viewModel: HomeScreenViewModel())
    }
}

