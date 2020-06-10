//
//  MovesSection.swift
//  SuperSmashBrosStats
//
//  Created by Kamaal Farah on 10/06/2020.
//  Copyright © 2020 Kamaal. All rights reserved.
//

import SwiftUI

struct MovesSection: View {
    var characterMoves: [CodableCharacterMoves]

    var body: some View {
        Section(header: Text(self.characterMoves.count > 0 ? self.characterMoves[0].moveType.rawValue.capitalized : "").font(.headline)) {
            ForEach(self.characterMoves) { move in
                HStack {
                    Text(move.name)
                }
            }
        }
    }
}

//struct MovesSection_Previews: PreviewProvider {
//    static var previews: some View {
//        MovesSection()
//    }
//}
