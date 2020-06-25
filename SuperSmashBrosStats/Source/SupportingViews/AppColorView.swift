//
//  AppColorView.swift
//  SuperSmashBrosStats
//
//  Created by Kamaal Farah on 24/06/2020.
//  Copyright © 2020 Kamaal. All rights reserved.
//

import SwiftUI

struct AppColorView: View {
    var action: (_: ColorOption) -> Void

    var body: some View {
        VStack {
            ForEach(appColors) { (option: ColorOption) in
                Button(action: { self.action(option) }) {
                    HStack {
                        Text(option.name.rawValue)
                        Spacer()
                        option.color
                            .frame(width: 32, height: 32)
                            .cornerRadius(8)
                    }
                }
            }
        }
    }
}

//struct AppColorView_Previews: PreviewProvider {
//    static var previews: some View {
//        AppColorView(action: )
//    }
//}
