//
//  SettingsScreenContentView.swift
//  SuperSmashBrosStats
//
//  Created by Kamaal Farah on 21/06/2020.
//  Copyright © 2020 Kamaal. All rights reserved.
//

import SwiftUI

struct SettingsScreenContentView: View {
    @EnvironmentObject
    private var userData: UserDataModel

    @ObservedObject
    private var viewModel = SettingsScreenViewModel()

    var body: some View {
        List {
            Section(header: Text("")) {
                LanguageSettingsRow(action: self.viewModel.languageSettingsAction)
                AppColorSettingsRow(action: self.viewModel.appColorSettingsAction)
            }
            ShareFeedbackSettingsRow(action: self.viewModel.shareFeedbackSettingsAction)
            VersionSettingsRow(version: self.viewModel.versionNumberText)
        }
        .listStyle(GroupedListStyle())
        .environment(\.horizontalSizeClass, .regular)
        .navigationBarTitle(Text(localized: .SETTINGS), displayMode: .large)
        .sheet(isPresented: self.$viewModel.showSheet) {
            self.currentSheet()
        }
    }

    private func currentSheet() -> some View {
        switch self.viewModel.currentSheet {
        case .appColor:
            return AnyView(
                Text("yo")
            )
        case .mail:
            return AnyView(
                MailView(showFeedbackSheet: self.$viewModel.showSheet, mailResult: self.$viewModel.mailResult)
            )
        }
    }
}

struct SettingsScreenContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SettingsScreenContentView()
        }
//        .colorScheme(.dark)
    }
}
