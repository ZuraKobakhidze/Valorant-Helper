//
//  SingleAgentModel.swift
//  Valorant Helper
//
//  Created by Zura Kobakhidze on 25.02.22.
//

import Foundation

struct SingleAgentModel: Codable {
    let displayName: String?
    let description: String?
    let fullPortrait: String?
    let background: String?
    let role: SingleAgentRoleModel?
    let abilities: [SingleAgentAbility?]?
}

struct SingleAgentRoleModel: Codable {
    let displayName: String?
    let description: String?
    let displayIcon: String?
}

struct SingleAgentAbility: Codable {
    let displayName: String?
    let description: String?
    let displayIcon: String?
}
