//
//  SettingsScreenViewModel.swift
//  SuperSmashBrosStats
//
//  Created by Kamaal Farah on 21/06/2020.
//  Copyright © 2020 Kamaal. All rights reserved.
//

import Combine
import MessageUI

final class SettingsScreenViewModel: ObservableObject {

    @Published var showLanguageActionSheet = false
    @Published var showAppColorSheet = false
    @Published var showFeedbackSheet = false
    @Published var mailResult: Result<MFMailComposeResult, Error>?

    var versionNumberText: String {
        return "1"
    }

    func languageSettingsAction() {
        self.showLanguageActionSheet = true
    }

    func appColorSettingsAction() {
        self.showAppColorSheet = true
    }

    func shareFeedbackSettingsAction() {
        self.showFeedbackSheet = true
    }

}
