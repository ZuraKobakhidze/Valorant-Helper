//
//  LineUpsMapsModel.swift
//  Valorant Helper
//
//  Created by Zura Kobakhidze on 02.03.22.
//

import Foundation

struct LineUpsMapsModel: Codable {
    let displayName: String?
    let listViewIcon: String?
    let site: [LineUpsMapsSiteModel]?
}

struct LineUpsMapsSiteModel: Codable {
    let siteName: String?
    let lineUpsUrl: String?
}
