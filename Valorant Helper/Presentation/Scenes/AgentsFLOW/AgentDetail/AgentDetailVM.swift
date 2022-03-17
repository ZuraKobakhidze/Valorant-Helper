import Foundation
import Combine

protocol AgentDetailVMProtocol {
    var item: SingleAgentModel? { get }
    var itemSubject: PassthroughSubject<Bool, Never> { get }
    init(name: String)
    func getItem()
}

class AgentDetailVM: AgentDetailVMProtocol {
    
    let name: String
    var item: SingleAgentModel?
    var itemSubject = PassthroughSubject<Bool, Never>()
    
    required init(name: String) {
        self.name = name
    }
    
    func getItem() {
        
        NetworkEngine.shared.request(endPoint: AgentsEndpoint.getSingleAgent(name: name)) { [weak self] (result: Result<SingleAgentModel, Error>) in
            
            switch result {
            case .success(let success):
                self?.item = success
                self?.itemSubject.send(true)
            case .failure(let failure):
                self?.itemSubject.send(false)
                print(failure.localizedDescription)
            }
            
        }
        
    }
    
}
