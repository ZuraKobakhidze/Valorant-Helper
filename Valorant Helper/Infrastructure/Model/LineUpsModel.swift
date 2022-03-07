//
//  LineUpsModel.swift
//  Valorant Helper
//
//  Created by Zura Kobakhidze on 28.02.22.
//

import Foundation

struct LineUpsModel: Codable {
    let displayName: String?
    let displayIcon: String?
    let pathName: String?
    let role: LineUpsRoleModel?
}

struct LineUpsRoleModel: Codable {
    let displayName: String?
}
