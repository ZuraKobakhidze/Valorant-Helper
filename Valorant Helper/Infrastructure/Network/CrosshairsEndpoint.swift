//
//  CrosshairsEndpoint.swift
//  Valorant Helper
//
//  Created by Zura Kobakhidze on 10.03.22.
//

import Foundation

enum CrosshairsEndpoint: Endpoint {
    
    case getAllCrosshairs
    
    var scheme: String {
        switch self {
            case .getAllCrosshairs:
                return "https"
        }
    }
    
    var baseURL: String {
        switch self {
            case .getAllCrosshairs:
                return "raw.githubusercontent.com"
        }
    }
    
    var path: String {
        switch self {
            case .getAllCrosshairs:
                return "/DimitriTsikaridze/Valorant-Helper-API/main/all-crosshairs.json"
        }
    }
    
    var method: String {
        switch self {
            case .getAllCrosshairs:
                return "GET"
        }
    }
    
}
