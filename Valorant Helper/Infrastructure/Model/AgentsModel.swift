//
//  AgentsModel.swift
//  Valorant Helper
//
//  Created by Zura Kobakhidze on 23.02.22.
//

import Foundation

struct AgentsModel: Codable {
    let uuid: String?
    let displayName: String?
    let bustPortrait: String?
    let background: String?
    let pathName: String?
    let role: AgentsRoleModel?
}

struct AgentsRoleModel: Codable {
    let displayName: String?
    let displayIcon: String?
}
