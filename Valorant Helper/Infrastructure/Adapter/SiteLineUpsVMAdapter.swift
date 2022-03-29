//
//  SiteLineUpsVMFactory.swift
//  Valorant Helper
//
//  Created by Zura Kobakhidze on 09.03.22.
//

import Foundation

class SiteLineUpsVMAdapter{
    
    static func getSiteLineUpsVM(from vm: LineUpsMapVMProtocol?, index: IndexPath) -> SiteLineUpsProtocol? {
        
        SiteLineUpsVM(
            itemList: vm?.itemList[index.section].item?.site?[index.row-1]?.lineUps.map { $0.map { SiteLineUpsCellVM(item: $0, agentImage: vm?.agentImage) } },
            agentPath: vm?.agentPath,
            mapIcon: vm?.itemList[index.section].item?.listViewIcon,
            mapName: vm?.itemList[index.section].item?.displayName,
            siteName: vm?.itemList[index.section].item?.site?[index.row-1]?.siteName,
            agentImage: vm?.agentImage)
        
    }
    
}
