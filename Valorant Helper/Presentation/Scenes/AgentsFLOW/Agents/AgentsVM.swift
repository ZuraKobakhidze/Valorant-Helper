import Foundation
import Combine

protocol AgentsVMProtocol {
    var itemList: [AgentsCellVM]? { get }
    var fullItemList: [AgentsCellVM]? { get }
    var itemSubject: PassthroughSubject<Bool, Never> { get }
    func getAllItems()
    func filterItemList(by agentType: AgentsDataType)
}

class AgentsVM: AgentsVMProtocol {
    
    var itemList: [AgentsCellVM]? = [AgentsCellVM]()
    var fullItemList: [AgentsCellVM]? = [AgentsCellVM]()
    var itemSubject = PassthroughSubject<Bool, Never>()
    
    func getAllItems() {
        
        NetworkEngine.shared.request(endPoint: AgentsEndpoint.getAllAgent) { [weak self] (result: Result<AgentsModelList, Error>) in
            switch result {
                case .success(let success):
                    self?.fullItemList = success.data?.filter { $0?.isPlayableCharacter != false }.map { AgentsCellVMFactory.getAgentsCellVM(from: $0) }
                    self?.itemList = self?.fullItemList
                    self?.itemSubject.send(true)
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
        
    }
    
    func filterItemList(by agentType: AgentsDataType) {
        
        switch agentType {
            case .all:
                itemList = fullItemList
                itemSubject.send(true)
            default:
                itemList = fullItemList?.filter { $0.roleName?.uppercased() == agentType.rawValue }
                itemSubject.send(true)
        }
        
    }
    
}
