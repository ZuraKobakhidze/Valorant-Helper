//
//  LineUpDetailVMFactory.swift
//  Valorant Helper
//
//  Created by Zura Kobakhidze on 09.03.22.
//

import Foundation

class LineUpDetailVMFactory {
    
    static func getLineUpDetailVM(from vm: SiteLineUpsProtocol?, index: IndexPath) -> LineUpDetailVMProtocol {
        
        LineUpDetailVM(
            agentPath: vm?.agentPath,
            lineUpIdentifier: vm?.itemList?[index.row]?.item,
            mapIcon: vm?.mapIcon)
        
    }
    
}
