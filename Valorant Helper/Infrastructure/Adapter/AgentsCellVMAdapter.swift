//
//  AgentsCellVMFactory.swift
//  Valorant Helper
//
//  Created by Zura Kobakhidze on 23.02.22.
//

import Foundation

class AgentsCellVMAdapter {
    
    static func getAgentsCellVM(from vm: AgentsModel?) -> AgentsCellVM {
     
        AgentsCellVM(uuid: vm?.uuid,
                     displayName: vm?.displayName,
                     bustPortrait: vm?.bustPortrait,
                     background: vm?.background,
                     pathName: vm?.pathName,
                     roleName: vm?.role?.displayName,
                     roleIcon: vm?.role?.displayIcon)
        
    }
        
}
