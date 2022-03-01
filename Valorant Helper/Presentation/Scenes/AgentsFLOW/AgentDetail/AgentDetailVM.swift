import Foundation
import Combine

protocol AgentDetailVMProtocol {
    var item: SingleAgentModel? { get }
    var itemSubject: PassthroughSubject<Bool, Never> { get }
    init(agentID: String)
    func getItem()
}

class AgentDetailVM: AgentDetailVMProtocol {
    
    let agentID: String
    var item: SingleAgentModel?
    var itemSubject = PassthroughSubject<Bool, Never>()
    
    required init(agentID: String) {
        self.agentID = agentID
    }
    
    func getItem() {
        
        NetworkEngine.shared.request(endPoint: AgentsEndpoint.getSingleAgent(agentId: agentID)) { [weak self] (result: Result<SingleAgentModelList, Error>) in
            
            switch result {
            case .success(let success):
                self?.item = success.data
                self?.itemSubject.send(true)
            case .failure(let failure):
                print(failure.localizedDescription)
            }
            
        }
        
    }
    
}
