import Foundation

protocol LineUpsMapVMProtocol {
    var agentId: String { get }
    var agentImage: String { get }
    init(agentId: String, agentImage: String)
}

class LineUpsMapVM: LineUpsMapVMProtocol {
    
    var agentId: String
    var agentImage: String
    
    required init(agentId: String, agentImage: String) {
        self.agentId = agentId
        self.agentImage = agentImage
    }
    
    
    
}
