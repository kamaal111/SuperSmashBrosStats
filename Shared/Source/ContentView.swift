//
//  ContentView.swift
//  SuperSmashBrosStats
//
//  Created by Kamaal Farah on 23/06/2020.
//  Copyright © 2020 Kamaal. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var selection = 0

    var body: some View {
        TabView(selection: self.$selection,
                content: {
                    NavigationView { HomeScreenContentView() }
                        .tabItem {
                            Image(systemName: "s.circle")
                            Text(localized: .STATS)
                        }.tag(0)
                    NavigationView { SettingsScreenContentView() }
                        .tabItem {
                            Image(systemName: "slider.horizontal.3")
                            Text(localized: .SETTINGS)
                        }.tag(1)
                })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
