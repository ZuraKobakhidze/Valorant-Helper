import Foundation

protocol CrosshairDetailVMProtocol: ViewModel {
    var item: CrosshairsModel? { get }
    init(item: CrosshairsModel?)
    func saveItemToFavourite()
}

class CrosshairDetailVM: CrosshairDetailVMProtocol {
    
    var item: CrosshairsModel?
    let coreDataManager: CoreDataManagerProtocol = CrosshairCoreDataManager()
    
    required init(item: CrosshairsModel?) {
        self.item = item
    }
    
    func saveItemToFavourite() {
        
        coreDataManager.save(viewModel: self)
        
    }
    
}
