import Combine

protocol CrosshairDetailVMProtocol: ViewModel {
    var favouritedSubject: PassthroughSubject<Bool, Never> { get }
    var item: CrosshairsModel? { get }
    var itemSubject: PassthroughSubject<Bool, Never> { get }
    init(id: String?)
    func getItem() 
    func onFavourite()
    func checkIfFavourite() 
}

class CrosshairDetailVM: CrosshairDetailVMProtocol {
    
    var favouritedSubject = PassthroughSubject<Bool, Never>()
    var favourited: Bool?
    var item: CrosshairsModel?
    var id: String?
    var itemSubject = PassthroughSubject<Bool, Never>()
    let coreDataManager = CrosshairCoreDataManager()
    
    required init(id: String?) {
        self.id = id
    }
    
    func getItem() {
        
        NetworkEngine.shared.request(endPoint: CrosshairsEndpoint.getSingleCrosshair(id: id ?? "")) { [weak self] (result: Result<CrosshairsModel, Error>) in
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
    
    func onFavourite() {
        
        if favourited ?? false {
            coreDataManager.delete(id: id ?? "")
            favourited?.toggle()
            favouritedSubject.send(favourited ?? false)
        } else {
            coreDataManager.save(viewModel: self)
            favourited?.toggle()
            favouritedSubject.send(favourited ?? false)
        }
        
    }
    
    func checkIfFavourite() {
        coreDataManager.ifExists(id: id ?? "") { [weak self] bool in
            self?.favourited = bool
            self?.favouritedSubject.send(self?.favourited ?? false)
        }
    }
    
}
