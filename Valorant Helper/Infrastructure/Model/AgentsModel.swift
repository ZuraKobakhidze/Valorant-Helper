//
//  AgentsModel.swift
//  Valorant Helper
//
//  Created by Zura Kobakhidze on 23.02.22.
//

import Foundation

struct AgentsModelList: Codable {
    let data: [AgentsModel?]?
}

struct AgentsModel: Codable {
    let uuid: String?
    let displayName: String?
    let bustPortrait: String?
    let background: String?
    let isPlayableCharacter: Bool?
    let role: AgentsRoleModel?
}

struct AgentsRoleModel: Codable {
    let displayName: String?
    let displayIcon: String?
}
