//
//  AvatarEndPoint.swift
//  GoodNetworkLayer
//
//  Created by Zura Kobakhidze on 02.02.22.
//

import Foundation

enum AgentsEndpoint: Endpoint {
    
    case getAllAgent
    case getSingleAgent(agentId: String)
    
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
                return "valorant-api.com"
            case .getSingleAgent:
                return "valorant-api.com"
        }
    }
    
    var path: String {
        switch self {
            case .getAllAgent:
                return "/v1/agents"
            case .getSingleAgent(let id):
                return "/v1/agents/\(id)"
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


