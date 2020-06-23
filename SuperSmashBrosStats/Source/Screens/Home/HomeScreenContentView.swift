//
//  HomeScreenContentView.swift
//  SuperSmashBrosStats
//
//  Created by Kamaal Farah on 06/06/2020.
//  Copyright © 2020 Kamaal. All rights reserved.
//

import SwiftUI

struct HomeScreenContentView: View {
    @Environment(\.colorScheme)
    private var colorScheme

    @EnvironmentObject
    private var userData: UserDataModel

    @ObservedObject
    private var viewModel = HomeScreenViewModel()

    var body: some View {
        VStack {
            NavigationLink(destination: CharacterListScreenContentView(game: .smash4)) {
                    Image("smash4logo")
                        .renderingMode(.original)
                        .resizable()
                        .frame(height: Self.imageHeight)
            }
            NavigationLink(destination: CharacterListScreenContentView(game: .ultimate)) {
                    self.ultimateLogoImage
            }
        }
        .padding(.horizontal, 20)
        .navigationBarTitle(Text(localized: .SUPER_SMASH_STATS), displayMode: .large)
    }

    private var ultimateLogoImage: some View {
        let image = Image("ultimatelogo")
            .renderingMode(.original)
            .resizable()
            .frame(height: Self.imageHeight)
        if self.colorScheme == .dark {
            return AnyView(image.colorInvert())
        } else {
            return AnyView(image)
        }
    }

    static private let imageHeight: CGFloat = 200
}
