import Foundation
import Combine

protocol LineUpDetailVMProtocol: ViewModel {
    var favouritedSubject: PassthroughSubject<Bool, Never> { get }
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
    func onFavourite()
    func checkIfFavourite() 
}

class LineUpDetailVM: LineUpDetailVMProtocol {
    
    var favouritedSubject = PassthroughSubject<Bool, Never>()
    var favourited: Bool?
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
                    self?.checkIfFavourite()
                case .failure(let failure):
                    self?.itemSubject.send(false)
                    print(failure.localizedDescription)
            }
        }
        
    }
    
    func onFavourite() {
        
        if favourited ?? false {
            coreDataManager.delete(id: item?.id ?? "")
            favourited?.toggle()
            favouritedSubject.send(favourited ?? false)
        } else {
            coreDataManager.save(viewModel: self)
            favourited?.toggle()
            favouritedSubject.send(favourited ?? false)
        }
        
    }
    
    func checkIfFavourite() {
        
        if let id = item?.id {
            DispatchQueue.main.async { [weak self] in
                self?.coreDataManager.ifExists(id: id) { [weak self] bool in
                    self?.favourited = bool
                    self?.favouritedSubject.send(self?.favourited ?? false)
                }
            }
        }
        
    }
    
}
