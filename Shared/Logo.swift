//
//  Logo.swift
//  SuperSmashBrosStats
//
//  Created by Kamaal Farah on 25/06/2020.
//  Copyright © 2020 Kamaal. All rights reserved.
//

import SwiftUI

struct Logo: View {
    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(.red)
                .frame(width: 160, height: 160)
            Text(localized: .SUPER_SMASH_STATS)
                .font(.system(size: 26, weight: .semibold, design: .monospaced))
                .foregroundColor(.white)
        }
    }
}

struct Logo_Previews: PreviewProvider {
    static var previews: some View {
        Logo()
            .previewLayout(.sizeThatFits)
            .padding(.all, 10)
    }
}
