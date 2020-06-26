//
//  ContentView.swift
//  SuperSmashBrosStats
//
//  Created by Kamaal Farah on 23/06/2020.
//  Copyright © 2020 Kamaal. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject
    private var splashScreenViewModel = SplashScreenViewModel()

    @State private var selection = 0

    var body: some View {
        ZStack {
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
                .opacity(self.splashScreenViewModel.showSplash ? 0 : 1)
            Logo()
                .opacity(self.splashScreenVisiblity)
                .rotationEffect(.degrees(self.splashScreenViewModel.spinLogoDegrees),
                                anchor: .center)
                .onAppear(perform: self.splashScreenViewModel.onSplashScreenAppear)
        }
    }

    private var splashScreenVisiblity: Double {
        return self.splashScreenViewModel.showSplash ? 1 : 0
    }
}

final class SplashScreenViewModel: ObservableObject {
    @Published var showSplash = true
    @Published var spinLogoDegrees: Double = 0

    private let splashScreenTime: Double  = 0.5
    private let spinTime: Double = 1

    func onSplashScreenAppear() {
        DispatchQueue.main.asyncAfter(deadline: .now() + self.spinTime) {
            withAnimation(.easeInOut(duration: self.spinTime)) {
                self.spinLogoDegrees += 360
            }
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + self.spinTime + self.splashScreenTime) {
            withAnimation(.easeInOut(duration: 1)) {
                self.showSplash = false
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
