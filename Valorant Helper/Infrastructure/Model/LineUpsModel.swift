//
//  LineUpsModel.swift
//  Valorant Helper
//
//  Created by Zura Kobakhidze on 28.02.22.
//

import Foundation

struct LineUpsModelList: Codable {
    let data: [LineUpsModel?]?
}

struct LineUpsModel: Codable {
    let uuid: String?
    let displayName: String?
    let displayIconSmall: String?
    let isPlayableCharacter: Bool?
    let role: LineUpsRoleModel?
}

struct LineUpsRoleModel: Codable {
    let displayName: String?
}
