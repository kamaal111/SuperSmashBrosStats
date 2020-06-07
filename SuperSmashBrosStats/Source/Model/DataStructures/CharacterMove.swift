//
//  CharacterMove.swift
//  SuperSmashBrosStats
//
//  Created by Kamaal Farah on 06/06/2020.
//  Copyright © 2020 Kamaal. All rights reserved.
//

import Foundation

struct CodableCharacterMove: Codable {
    let id: String
    let name: String
    let ownerId: Int
    let owner: String
    let hitboxActive: String
    let firstActionableFrame: String
    let baseDamage: String
    let angle: String
    let baseKnockBackSetKnockback: String
    let landingLag: String?
    let autoCancel: String?
    let knockbackGrowth: String
    let moveType: String
    let isWeightDependent: Bool
    let game: String
    let related: CodableRelated

    private enum CodingKeys: String, CodingKey {
        case id = "InstanceId"
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
}
