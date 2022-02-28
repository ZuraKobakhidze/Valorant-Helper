//
//  LineUpsEndpoint.swift
//  Valorant Helper
//
//  Created by Zura Kobakhidze on 28.02.22.
//

import Foundation

enum LineUpsEndpoint: Endpoint {
    
    case getAllAgent
    
    var scheme: String {
        switch self {
            case .getAllAgent:
                return "https"
        }
    }
    
    var baseURL: String {
        switch self {
            case .getAllAgent:
                return "valorant-api.com"
        }
    }
    
    var path: String {
        switch self {
            case .getAllAgent:
                return "/v1/agents"
        }
    }
    
    var method: String {
        switch self {
            case .getAllAgent:
                return "GET"
        }
    }
    
}
