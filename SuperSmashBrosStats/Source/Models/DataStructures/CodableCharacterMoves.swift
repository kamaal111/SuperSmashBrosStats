//
//  CharacterMoves.swift
//  SuperSmashBrosStats
//
//  Created by Kamaal Farah on 06/06/2020.
//  Copyright © 2020 Kamaal. All rights reserved.
//

import Foundation

struct CodableCharacterMoves: Codable, Hashable, Identifiable {
    let id: String // swiftlint:disable:this identifier_name
    let name: String
    let ownerId: Int
    let owner: String
    let hitboxActive: String?
    let firstActionableFrame: String?
    let baseDamage: String
    let angle: String
    let baseKnockBackSetKnockback: String
    let landingLag: String?
    let autoCancel: String?
    let knockbackGrowth: String
    let moveType: MoveType
    let isWeightDependent: Bool
    let game: String
    let related: CodableRelated

    var unwrappedMoveStats: [String: String] {
        let baseDamage = String(self.baseDamage.split(separator: "\n")[0])
        var moveStats = [
            "Base Damage": baseDamage,
            "Angle": self.angle,
            "Base Knock Back": self.baseKnockBackSetKnockback,
            "Is Weight Dependent": self.isWeightDependent ? "Yes" : "No",
            "Knockback Growth": self.knockbackGrowth
        ]
        if let autoCancel = self.autoCancel {
            moveStats["Auto Cancel"] = autoCancel
        }
        if let firstActionableFrame = self.firstActionableFrame {
            moveStats["First Actionable Frame"] = firstActionableFrame
        }
        if let hitboxActive = self.hitboxActive {
            moveStats["Hitbox Active"] = hitboxActive
        }
        if let landingLeg = self.landingLag {
            moveStats["Landing Leg"] = landingLeg
        }
        return moveStats
    }

    enum MoveType: String, CaseIterable, Codable, Hashable {
        case ground
        case aerial
        case special
        case throwMove = "throw"
    }

    private enum CodingKeys: String, CodingKey {
        case id = "InstanceId" // swiftlint:disable:this identifier_name
        case name = "Name"
        case ownerId = "OwnerId"
        case owner = "Owner"
        case hitboxActive = "HitboxActive"
        case firstActionableFrame = "FirstActionableFrame"
        case baseDamage = "BaseDamage"
        case angle = "Angle"
        case baseKnockBackSetKnockback = "BaseKnockBackSetKnockback"
        case landingLag = "LandingLag"
        case autoCancel = "AutoCancel"
        case knockbackGrowth = "KnockbackGrowth"
        case moveType = "MoveType"
        case isWeightDependent = "IsWeightDependent"
        case game = "Game"
        case related = "Related"
    }

    struct CodableRelated: Codable, Hashable {
        let ultimate: CodableRelatedLinks?
        let smash4: CodableRelatedLinks?

        private enum CodingKeys: String, CodingKey { // swiftlint:disable:this nesting
            case ultimate = "Ultimate"
            case smash4 = "Smash4"
        }
    }

    struct CodableRelatedLinks: Codable, Hashable {
        let itSelf: String?
        let character: String?

        private enum CodingKeys: String, CodingKey { // swiftlint:disable:this nesting
            case itSelf = "Self"
            case character = "Character"
        }
    }
}
