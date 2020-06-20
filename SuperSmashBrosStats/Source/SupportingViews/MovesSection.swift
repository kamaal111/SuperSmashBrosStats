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
        Section(header: Text(self.sectionHeader).font(.headline)) {
            ForEach(self.characterMoves) { (move: CodableCharacterMoves) in
                CharacterMoveView(move: move)
            }
        }
    }

    private var sectionHeader: String {
        if self.characterMoves.isEmpty { return "" }
        return self.characterMoves.first?.moveType.rawValue.capitalized ?? ""
    }
}

struct MovesSection_Previews: PreviewProvider {
    static let characterMove = CodableCharacterMoves(
        id: "1",
        name: "The move",
        ownerId: 1,
        owner: "Kamaal",
        hitboxActive: "3/4/5",
        firstActionableFrame: "20",
        baseDamage: "3001",
        angle: "90",
        baseKnockBackSetKnockback: "30",
        landingLag: "0",
        autoCancel: "40>",
        knockbackGrowth: "20",
        moveType: CodableCharacterMoves.MoveType.aerial,
        isWeightDependent: true,
        game: "ultimate2",
        related: CodableCharacterMoves.CodableRelated(ultimate: nil, smash4: nil))

    static var previews: some View {
        List {
            MovesSection(characterMoves: [Self.characterMove])
        }
    }
}
