//
//  LineUpsEndpoint.swift
//  Valorant Helper
//
//  Created by Zura Kobakhidze on 28.02.22.
//

import Foundation

enum LineUpsEndpoint: Endpoint {
    
    case getAllAgent
    case getMapsForAgent
    
    var scheme: String {
        switch self {
            case .getAllAgent:
                return "https"
            case .getMapsForAgent:
                return "https"
        }
    }
    
    var baseURL: String {
        switch self {
            case .getAllAgent:
                return "valorant-api.com"
            case .getMapsForAgent:
                return "run.mocky.io"
        }
    }
    
    var path: String {
        switch self {
            case .getAllAgent:
                return "/v1/agents"
            case .getMapsForAgent:
                return "/v3/4a645420-6523-417f-9af7-b91ea93436e8"
        }
    }
    
    var method: String {
        switch self {
            case .getAllAgent:
                return "GET"
            case .getMapsForAgent:
                return "GET"
        }
    }
    
}
