//
//  CrosshairsEndpoint.swift
//  Valorant Helper
//
//  Created by Zura Kobakhidze on 10.03.22.
//

import Foundation

enum CrosshairsEndpoint: Endpoint {
    
    case getAllCrosshairs
    case getSingleCrosshair(id: String)
    
    var scheme: String {
        switch self {
            case .getAllCrosshairs:
                return "https"
            case .getSingleCrosshair:
                return "https"
        }
    }
    
    var baseURL: String {
        switch self {
            case .getAllCrosshairs:
                return "raw.githubusercontent.com"
            case .getSingleCrosshair:
                return "raw.githubusercontent.com"
        }
    }
    
    var path: String {
        switch self {
            case .getAllCrosshairs:
                return "/DimitriTsikaridze/Valorant-Helper-API/main/all-crosshairs.json"
            case .getSingleCrosshair(let id):
                return "/DimitriTsikaridze/Valorant-Helper-API/main/crosshairs/\(id).json"
        }
    }
    
    var method: String {
        switch self {
            case .getAllCrosshairs:
                return "GET"
            case .getSingleCrosshair:
                return "GET"
        }
    }
    
}
