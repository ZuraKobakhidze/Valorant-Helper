import Foundation
import Combine

protocol LineUpsVMProtocol {
    var itemList: [LineUpsModel?]? { get }
    var fullItemList: [LineUpsModel?]? { get }
    var itemSubject: PassthroughSubject<Bool, Never> { get }
    func getAllItems()
    func filterItemList(by agentType: AgentsDataType)
    func refreshItemList(by agentType: AgentsDataType)
}

class LineUpsVM: LineUpsVMProtocol {
    
    var itemList: [LineUpsModel?]? = [LineUpsModel]()
    var fullItemList: [LineUpsModel?]? = [LineUpsModel]()
    var itemSubject = PassthroughSubject<Bool, Never>()
    
    func getAllItems() {
        
        NetworkEngine.shared.request(endPoint: LineUpsEndpoint.getAllAgent) { [weak self] (result: Result<[LineUpsModel], Error>) in
            switch result {
                case .success(let success):
                    self?.fullItemList = success
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
                itemList = fullItemList?.filter { $0?.role?.displayName?.uppercased() == agentType.rawValue }
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
        
        NetworkEngine.shared.request(endPoint: LineUpsEndpoint.getAllAgent) { [weak self] (result: Result<[LineUpsModel], Error>) in
            switch result {
                case .success(let success):
                    self?.fullItemList = success
                    self?.itemList = self?.fullItemList
                    self?.filterItemList(by: agentType)
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
        
    }
    
}
