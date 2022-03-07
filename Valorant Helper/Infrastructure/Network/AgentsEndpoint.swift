//
//  AvatarEndPoint.swift
//  GoodNetworkLayer
//
//  Created by Zura Kobakhidze on 02.02.22.
//

import Foundation

enum AgentsEndpoint: Endpoint {
    
    case getAllAgent
    case getSingleAgent(name: String)
    
    var scheme: String {
        switch self {
            case .getAllAgent:
                return "https"
            case .getSingleAgent:
                return "https"
        }
    }
    
    var baseURL: String {
        switch self {
            case .getAllAgent:
                return "raw.githubusercontent.com"
            case .getSingleAgent:
                return "raw.githubusercontent.com"
        }
    }
    
    var path: String {
        switch self {
            case .getAllAgent:
                return "/DimitriTsikaridze/Valorant-Helper-API/main/all-agents.json"
            case .getSingleAgent(let name):
                return "/DimitriTsikaridze/Valorant-Helper-API/main/agents/\(name).json"
        }
    }
    
    var method: String {
        switch self {
            case .getAllAgent:
                return "GET"
            case .getSingleAgent:
                return "GET"
        }
    }
    
}


