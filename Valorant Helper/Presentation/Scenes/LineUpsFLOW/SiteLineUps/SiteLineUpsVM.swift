import Foundation

protocol SiteLineUpsProtocol {
    var itemList: [SiteLineUpsCellVM?]? { get }
    var agentPath: String? { get }
    var mapIcon: String? { get }
    var agentImage: String? { get }
    var headerName: NSAttributedString? { get }
    var getSiteName: String? { get }
    init(itemList: [SiteLineUpsCellVM?]?, agentPath: String?, mapIcon: String?, mapName: String?, siteName: String?, agentImage: String?)
}

class SiteLineUpsVM: SiteLineUpsProtocol {
    
    var itemList: [SiteLineUpsCellVM?]?
    var agentPath: String?
    var mapIcon: String?
    var agentImage: String?
    var mapName: String?
    var siteName: String?
    
    required init(itemList: [SiteLineUpsCellVM?]?, agentPath: String?, mapIcon: String?, mapName: String?, siteName: String?, agentImage: String?) {
        self.itemList = itemList
        self.agentPath = agentPath
        self.mapIcon = mapIcon
        self.mapName = mapName
        self.siteName = siteName
        self.agentImage = agentImage
    }
    
    var headerName: NSAttributedString? {
        NSMutableAttributedString()
            .text("\(mapName?.uppercased() ?? "") - ", font: AppFont.getBold(ofSize: 18), color: AppColor.extraBlack.color, bgColor: nil, underlineStyle: nil, underlineColor: nil, strikeStyle: nil, strikeColor: nil)
            .text(siteName ?? "", font: AppFont.getBold(ofSize: 18), color: AppColor.mediumRed.color, bgColor: nil, underlineStyle: nil, underlineColor: nil, strikeStyle: nil, strikeColor: nil)
    }
    
    var getSiteName: String? {
        "\(mapName ?? "") - \(siteName ?? "")"
    }
    
}
