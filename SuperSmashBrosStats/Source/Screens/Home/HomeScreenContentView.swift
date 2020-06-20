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
        ZStack {
            CharacterListScreenContentView(game: self.viewModel.currentGame)
        }
    }
}
