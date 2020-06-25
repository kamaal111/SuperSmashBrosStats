//
//  CharacterMoveView.swift
//  SuperSmashBrosStats
//
//  Created by Kamaal Farah on 18/06/2020.
//  Copyright © 2020 Kamaal. All rights reserved.
//

import SwiftUI

struct CharacterMoveView: View {
    @State private var expandMovesDetails = false

    let move: CodableCharacterMoves

    var body: some View {
        Button(action: self.expandMoveAction) {
            HStack {
                VStack(alignment: .leading) {
                    Text(self.move.name)
                        .font(.body)
                        .foregroundColor(.accentColor)
                    if self.expandMovesDetails {
                        ForEach(self.move.unwrappedMoveStats.keys.sorted(), id: \.self) { key in
                            Text("\(key): \(self.move.unwrappedMoveStats[key] ?? "")")
                                .font(.body)
                        }
                    }
                }
                Spacer()
                VStack {
                    Image(systemName: "chevron.right")
                        .imageScale(.medium)
                        .foregroundColor(.gray)
                        .rotationEffect(.degrees(self.chevronAngle))
                        .padding(.top, self.expandMovesDetails ? 16 : 0)
                    if self.expandMovesDetails {
                        Spacer()
                    }
                }
            }
        }
    }

    private var chevronAngle: Double {
        if self.expandMovesDetails { return 90 }
        return 0
    }

    private func expandMoveAction() {
        if self.expandMovesDetails {
            withAnimation { self.expandMovesDetails = false }
        } else {
            withAnimation { self.expandMovesDetails = true }
        }
    }
}

//struct CharacterMoveView_Previews: PreviewProvider {
//    static var previews: some View {
//        CharacterMoveView()
//    }
//}
