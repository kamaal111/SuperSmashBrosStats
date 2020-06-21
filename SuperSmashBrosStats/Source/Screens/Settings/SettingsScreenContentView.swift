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
    var viewModel: SettingsScreenViewModel

    var body: some View {
        ZStack {
            List {
                Section(header: Text("")) {
                    LanguageSettingsRow {
                        print("Show language action sheet")
                    }
                    AppColorSettingsRow {
                        print("show app color sheet")
                    }
                }
                ShareFeedbackSettingsRow {
                    print("Show mail sheet")
                }
                VersionSettingsRow(version: "1")
            }
            .listStyle(GroupedListStyle())
            .environment(\.horizontalSizeClass, .regular)
        }
        .navigationBarTitle(Text(localized: .SETTINGS), displayMode: .large)
    }
}

struct SettingsScreenContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SettingsScreenContentView(viewModel: SettingsScreenViewModel())
        }
//        .colorScheme(.dark)
    }
}
