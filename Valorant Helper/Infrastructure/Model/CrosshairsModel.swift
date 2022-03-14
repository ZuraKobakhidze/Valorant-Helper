//
//  CrosshairsModel.swift
//  Valorant Helper
//
//  Created by Zura Kobakhidze on 10.03.22.
//

import Foundation

struct CrosshairsModel: Codable {
    let name: String?
    let coverImage: String?
    let crosshairDetail: [CrosshairDetailModel]?
}

struct CrosshairDetailModel: Codable {
    let orderNumber: Int?
    let value: String?
    let description: String?
}
