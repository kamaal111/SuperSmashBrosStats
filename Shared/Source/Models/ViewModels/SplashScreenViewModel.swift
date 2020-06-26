//
//  SplashScreenViewModel.swift
//  SuperSmashBrosStats
//
//  Created by Kamaal Farah on 26/06/2020.
//  Copyright © 2020 Kamaal. All rights reserved.
//

import SwiftUI
import Combine

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

    var splashScreenVisiblity: Double {
        return self.showSplash ? 1 : 0
    }

    var backGroundVisiblity: Double {
        return self.showSplash ? 0 : 1
    }
}
