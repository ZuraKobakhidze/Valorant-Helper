import Foundation
import CoreData
import Combine

class FavouritesVM {
    
    var itemList = [ViewModel]()
    var lineUpItems = [LineUpCD]()
    
    var currentIndex = 0
    var itemSubject = PassthroughSubject<Bool, Never>()
    let lineUpsCoreDataManager = LineUpCoreDataManager()
    
    func fetchData() {
        
        lineUpsCoreDataManager.read { [weak self] result in
            switch result {
            case .success(let success):
                self?.lineUpItems = success
                self?.itemList = self?.lineUpItems as [ViewModel]
                self?.itemSubject.send(true)
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
        
    }
    
}
