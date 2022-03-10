import Foundation
import Combine

protocol CrosshairsVMProtocol {
    var itemList: [CrosshairsModel] { get }
    var itemSubject: PassthroughSubject<Bool, Never> { get }
    func getItems()
}

class CrosshairsVM: CrosshairsVMProtocol {
    
    var itemList = [CrosshairsModel]()
    var itemSubject = PassthroughSubject<Bool, Never>()
    
    func getItems() {
        
        NetworkEngine.shared.request(endPoint: CrosshairsEndpoint.getAllCrosshairs) { [weak self] (result: Result<[CrosshairsModel], Error>) in
            switch result {
                case.success(let success):
                    self?.itemList = success
                    self?.itemSubject.send(true)
                case .failure(let failure):
                    print(failure.localizedDescription)
            }
        }
        
    }
    
}
