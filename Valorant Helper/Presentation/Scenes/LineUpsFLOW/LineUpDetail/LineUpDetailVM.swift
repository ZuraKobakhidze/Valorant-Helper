import Foundation
import Combine

protocol LineUpDetailVMProtocol: ViewModel {
    var agentPath: String? { get }
    var agentImage: String? { get }
    var lineUpIdentifier: SingleLineUpModel? { get }
    var mapIcon: String? { get }
    var site: String? { get }
    var item: LineUpModel? { get }
    var itemSubject: PassthroughSubject<Bool, Never> { get }
    var getRequiremets: String { get }
    init(agentImage: String?, agentPath: String?, lineUpIdentifier: SingleLineUpModel?, mapIcon: String?, site: String?)
    func getItem()
    func saveItemToFavourite()
}

class LineUpDetailVM: LineUpDetailVMProtocol {
    
    var agentPath: String?
    var agentImage: String?
    var lineUpIdentifier: SingleLineUpModel?
    var mapIcon: String?
    var site: String?
    var item: LineUpModel?
    var itemSubject = PassthroughSubject<Bool, Never>()
    
    let coreDataManager = LineUpCoreDataManager()
    
    var getRequiremets: String {
        item?.requirements?.map { "- \($0)" }.joined(separator: "\n") ?? "NONE"
    }
    
    required init(agentImage: String?, agentPath: String?, lineUpIdentifier: SingleLineUpModel?, mapIcon: String?, site: String?) {
        self.agentImage = agentImage
        self.agentPath = agentPath
        self.lineUpIdentifier = lineUpIdentifier
        self.mapIcon = mapIcon
        self.site = site
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
    
    func saveItemToFavourite() {
        coreDataManager.save(viewModel: self)
    }
    
}
