//
//  Grabber.swift
//  SuperSmashBrosStats
//
//  Created by Kamaal Farah on 25/06/2020.
//  Copyright © 2020 Kamaal. All rights reserved.
//

import SwiftUI

struct Grabber: View {
    var color: Color

    init(color: Color = .gray) {
        self.color = color
    }

    var body: some View {
        Rectangle()
            .foregroundColor(self.color)
            .frame(width: UIScreen.main.bounds.width / 4, height: 4)
            .cornerRadius(8)
    }
}

struct Grabber_Previews: PreviewProvider {
    static var previews: some View {
        Grabber()
            .padding(8)
            .previewLayout(.sizeThatFits)
    }
}
