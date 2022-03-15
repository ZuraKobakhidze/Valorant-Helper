import Foundation
import CoreData
import Combine

class FavouritesVM {
    
    var itemList = [ViewModel]()
    var lineUpItems = [LineUpCD]()
    var crosshairItems = [CrosshairCD]()
    
    var itemSubject = PassthroughSubject<Bool, Never>()
    let lineUpsCoreDataManager = LineUpCoreDataManager()
    let crosshairsCoreDataManager = CrosshairCoreDataManager()
    
    func fetchData() {
        
        lineUpsCoreDataManager.read { [weak self] result in
            switch result {
            case .success(let success):
                self?.lineUpItems = success
                self?.itemSubject.send(true)
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
        
        crosshairsCoreDataManager.read { [weak self] result in
            switch result {
            case .success(let success):
                self?.crosshairItems = success
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
        
    }
    
    func changeData(to index: Int) {
        if index == 0 {
            itemList = lineUpItems as [ViewModel]
            itemSubject.send(true)
        } else if index == 1 {
            itemList = crosshairItems as [ViewModel]
            itemSubject.send(true)
        }
    }
    
}
