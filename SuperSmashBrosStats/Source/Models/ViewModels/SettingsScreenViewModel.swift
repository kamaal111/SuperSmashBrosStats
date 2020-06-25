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

    @Published var showSheet = false
    @Published var currentSheet: SettingsSheet = .appColor

    @Published var showActionSheet = false
    @Published var currentActionSheet: SettingsActionSheet = .language

    @Published var mailResult: Result<MFMailComposeResult, Error>?

    var versionText: String {
        guard let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String else { return "" }
        return version
    }

    var currentAppColor: String {
        guard let appColor = LocalStorageHelper.getString(from: .appColor)
        else { return AppColors.blueAppColor.rawValue }
        return appColor
    }

    func languageSettingsAction() {
        self.currentActionSheet = .language
        self.showActionSheet = true
    }

    func appColorSettingsAction() {
        self.currentSheet = .appColor
        self.showSheet = true
    }

    func shareFeedbackSettingsAction() {
        self.currentSheet = .mail
        self.showSheet = true
    }

    func saveColorOption(of color: ColorOption) {
        LocalStorageHelper.save(this: color.name.rawValue, from: .appColor)
        UIApplication.shared.windows.forEach { window in
            if window.isKeyWindow {
                window.tintColor = .getAppColor(from: color.name.rawValue)
            }
        }
        self.showSheet = false
    }

}

enum SettingsSheet {
    case mail
    case appColor
}

enum SettingsActionSheet {
    case language
}
