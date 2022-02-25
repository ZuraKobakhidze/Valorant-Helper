//
//  SingleAgentModel.swift
//  Valorant Helper
//
//  Created by Zura Kobakhidze on 25.02.22.
//

import Foundation

struct SingleAgentModelList: Codable {
    let data: SingleAgentModel?
}

struct SingleAgentModel: Codable {
    let uuid: String?
    let displayName: String?
    let bustPortrait: String?
    let background: String?
    let isPlayableCharacter: Bool?
    let role: SingleAgentRoleModel?
    let abilities: [SingleAgentAbilitie?]?
}

struct SingleAgentRoleModel: Codable {
    let displayName: String?
    let description: String?
    let displayIcon: String?
}

struct SingleAgentAbilitie: Codable {
    let displayName: String?
    let description: String?
    let displayIcon: String?
}
