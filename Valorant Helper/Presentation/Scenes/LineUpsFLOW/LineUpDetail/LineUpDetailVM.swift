import Foundation
import Combine

protocol LineUpDetailVMProtocol {
    var agentPath: String? { get }
    var lineUpIdentifier: SingleLineUpModel? { get }
    var mapIcon: String? { get }
    var item: LineUpModel? { get }
    var itemSubject: PassthroughSubject<Bool, Never> { get }
    var getRequiremets: String { get }
    init(agentPath: String?, lineUpIdentifier: SingleLineUpModel?, mapIcon: String?)
    func getItem()
}

class LineUpDetailVM: LineUpDetailVMProtocol {
    
    var agentPath: String?
    var lineUpIdentifier: SingleLineUpModel?
    var mapIcon: String?
    var item: LineUpModel?
    var itemSubject = PassthroughSubject<Bool, Never>()
    
    required init(agentPath: String?, lineUpIdentifier: SingleLineUpModel?, mapIcon: String?) {
        self.agentPath = agentPath
        self.lineUpIdentifier = lineUpIdentifier
        self.mapIcon = mapIcon
    }
    
    func getItem() {
        
        NetworkEngine.shared.request(endPoint: LineUpsEndpoint.getSingleLineUp(agentPath: agentPath ?? "", lineUpPath: lineUpIdentifier?.lineUpPath ?? "")) { [weak self] (result: Result<LineUpModel, Error>) in
            switch result {
                case .success(let success):
                    self?.item = success
                    self?.itemSubject.send(true)
                case .failure(let failure):
                    print(failure.localizedDescription)
            }
        }
        
    }
    
    var getRequiremets: String {
        item?.requirements?.map { "- \($0)" }.joined(separator: "\n") ?? "NONE"
    }
    
}
