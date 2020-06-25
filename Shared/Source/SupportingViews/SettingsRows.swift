//
//  SettingsRows.swift
//  SuperSmashBrosStats
//
//  Created by Kamaal Farah on 21/06/2020.
//  Copyright © 2020 Kamaal. All rights reserved.
//

import SwiftUI

struct AppColorSettingsRow: View {
    var action: () -> Void

    var body: some View {
        Button(action: self.action) {
            HStack {
                Text("App Color")
                    .foregroundColor(.primary)
                Spacer()
                Rectangle()
                    .frame(width: 32, height: 32)
                    .cornerRadius(8)
            }
        }
    }
}

struct ShareFeedbackSettingsRow: View {
    var action: () -> Void

    var body: some View {
        Button(action: self.action) {
            HStack {
                Text("Share Feedback")
                    .foregroundColor(.primary)
                Spacer()
                Image(systemName: "paperplane")
            }
        }
    }
}

struct VersionSettingsRow: View {
    let version: String

    var body: some View {
        HStack {
            Text("Version")
            Spacer()
            Text(version)
        }
    }
}
