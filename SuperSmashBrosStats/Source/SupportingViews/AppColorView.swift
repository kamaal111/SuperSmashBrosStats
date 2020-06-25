//
//  AppColorView.swift
//  SuperSmashBrosStats
//
//  Created by Kamaal Farah on 24/06/2020.
//  Copyright © 2020 Kamaal. All rights reserved.
//

import SwiftUI

struct AppColorView: View {
    var currentAppColor: String
    var action: (_: ColorOption) -> Void

    var body: some View {
        VStack {
            Text("App Color")
                .font(.title)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 16)
                .padding(.top, 24)
            ForEach(appColors) { (option: ColorOption) in
                AppColorViewButton(option: option,
                                   isCurrentColor: self.checkIsCurrentColor(optionName: option.name.rawValue),
                                   action: self.action)
            }
            Spacer()
        }
    }

    func checkIsCurrentColor(optionName: String) -> Bool {
        return self.currentAppColor == optionName
    }
}

struct AppColorViewButton: View {
    var option: ColorOption
    var isCurrentColor: Bool
    var action: (_: ColorOption) -> Void

    var body: some View {
        Button(action: self.buttonAction) {
            HStack {
                Text(self.option.name.rawValue)
                    .padding(.leading, 16)
                    .foregroundColor(self.isCurrentColorTextColor)
                Spacer()
                self.option.color
                    .frame(width: 32, height: 32)
                    .cornerRadius(8)
                    .padding(.trailing, 16)
            }
        }
    }

    private var isCurrentColorTextColor: Color {
        if self.isCurrentColor {
            return .primary
        }
        return .accentColor
    }

    private func buttonAction() {
        self.action(self.option)
    }
}

struct AppColorView_Previews: PreviewProvider {
    static var previews: some View {
        AppColorView(currentAppColor: AppColors.blueAppColor.rawValue) { (option: ColorOption) in
            print(option.name)
        }
    }
}
