import Foundation

struct AgentsHeaderViewCellVM {
    let title: AgentsDataType
    var isOn: Bool
}

enum AgentsDataType: String {
    
    case all = "ALL"
    case initiator = "INITIATOR"
    case duelist = "DUELIST"
    case controller = "CONTROLLER"
    case sentinel = "SENTINEL"
    
    var getString: String {
        switch self {
        case .all:
            return "ALL".localized()
        case .initiator:
            return "INITIATOR".localized()
        case .duelist:
            return "DUELIST".localized()
        case .controller:
            return "CONTROLLER".localized()
        case .sentinel:
            return "SENTINEL".localized()
        }
    }
    
}
