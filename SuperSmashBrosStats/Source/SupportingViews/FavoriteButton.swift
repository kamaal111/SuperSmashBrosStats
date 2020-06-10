//
//  FavoriteButton.swift
//  SuperSmashBrosStats
//
//  Created by Kamaal Farah on 10/06/2020.
//  Copyright © 2020 Kamaal. All rights reserved.
//

import SwiftUI

struct FavoriteButton: View {
    var action: () -> Void
    var color: Color

    var body: some View {
        Button(action: self.action) {
            Image(systemName: "star.fill")
                .foregroundColor(self.color)
        }
    }
}

struct FavoriteButton_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteButton(action: {}, color: .red)
    }
}
