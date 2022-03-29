import Foundation
import Combine

protocol AgentsVMProtocol {
    var itemList: [AgentsCellVM]? { get }
    var fullItemList: [AgentsCellVM]? { get }
    var itemSubject: PassthroughSubject<Bool, Never> { get }
    func getAllItems()
    func filterItemList(by agentType: AgentsDataType)
    func refreshItemList(by agentType: AgentsDataType)
}

class AgentsVM: AgentsVMProtocol {
    
    var itemList: [AgentsCellVM]? = [AgentsCellVM]()
    var fullItemList: [AgentsCellVM]? = [AgentsCellVM]()
    var itemSubject = PassthroughSubject<Bool, Never>()
    
    func getAllItems() {
        
        NetworkEngine.shared.request(endPoint: AgentsEndpoint.getAllAgent) { [weak self] (result: Result<[AgentsModel], Error>) in
            switch result {
                case .success(let success):
                    self?.fullItemList = success.map { AgentsCellVMAdapter.getAgentsCellVM(from: $0) }
                    self?.itemList = self?.fullItemList
                    self?.itemSubject.send(true)
                case .failure(let error):
                    self?.itemSubject.send(false)
                    print(error.localizedDescription)
            }
        }
        
    }
    
    func filterItemList(by agentType: AgentsDataType) {
        
        switch agentType {
            case .all:
                itemList = fullItemList
                if let bool = itemList?.isEmpty {
                    if bool {
                        itemSubject.send(false)
                    } else {
                        itemSubject.send(true)
                    }
                }
            default:
                itemList = fullItemList?.filter { $0.roleName?.uppercased() == agentType.rawValue }
                if let bool = itemList?.isEmpty {
                    if bool {
                        itemSubject.send(false)
                    } else {
                        itemSubject.send(true)
                    }
                }
        }
        
    }
    
    func refreshItemList(by agentType: AgentsDataType) {
        
        NetworkEngine.shared.request(endPoint: AgentsEndpoint.getAllAgent) { [weak self] (result: Result<[AgentsModel], Error>) in
            switch result {
                case .success(let success):
                    self?.fullItemList = success.map { AgentsCellVMAdapter.getAgentsCellVM(from: $0) }
                    self?.itemList = self?.fullItemList
                    self?.filterItemList(by: agentType)
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
        
    }
    
}
