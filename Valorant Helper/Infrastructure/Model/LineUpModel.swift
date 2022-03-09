//
//  SingleLineUpModel.swift
//  Valorant Helper
//
//  Created by Zura Kobakhidze on 09.03.22.
//

import Foundation

struct LineUpModel: Codable {
    let name: String?
    let description: String?
    let requirements: [String]?
    let steps: [LineUpStep]?
}

struct LineUpStep: Codable {
    let stepNumber: Int?
    let stepImage: String?
}
