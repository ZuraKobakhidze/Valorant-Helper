//
//  LineUpsEndpoint.swift
//  Valorant Helper
//
//  Created by Zura Kobakhidze on 28.02.22.
//

import Foundation

enum LineUpsEndpoint: Endpoint {
    
    case getAllAgent
    case getMapsForAgent(agentPath: String)
    case getSingleLineUp(agentPath: String, lineUpPath: String)
    
    var scheme: String {
        switch self {
            case .getAllAgent:
                return "https"
            case .getMapsForAgent:
                return "https"
            case .getSingleLineUp:
                return "https"
        }
    }
    
    var baseURL: String {
        switch self {
            case .getAllAgent:
                return "raw.githubusercontent.com"
            case .getMapsForAgent:
                return "raw.githubusercontent.com"
            case .getSingleLineUp:
                return "raw.githubusercontent.com"
        }
    }
    
    var path: String {
        switch self {
            case .getAllAgent:
                return "/DimitriTsikaridze/Valorant-Helper-API/main/all-agents.json"
            case .getMapsForAgent(let agentPath):
                return "/DimitriTsikaridze/Valorant-Helper-API/main/lineups/\(agentPath)/all_lineups_\(agentPath).json"
            case.getSingleLineUp(let agentPath, let lineUpPath):
                return "/DimitriTsikaridze/Valorant-Helper-API/main/lineups/\(agentPath)/\(lineUpPath).json"
        }
    }
    
    var method: String {
        switch self {
            case .getAllAgent:
                return "GET"
            case .getMapsForAgent:
                return "GET"
            case .getSingleLineUp:
                return "GET"
        }
    }
    
}
