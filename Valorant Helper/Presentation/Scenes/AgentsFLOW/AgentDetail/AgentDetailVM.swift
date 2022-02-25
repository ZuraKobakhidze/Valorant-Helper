import Foundation
import Combine

class AgentDetailVM {
    
    let agentID: String
    var item: SingleAgentModel?
    var itemSubject = PassthroughSubject<Bool, Never>()
    
    init(agentID: String) {
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
