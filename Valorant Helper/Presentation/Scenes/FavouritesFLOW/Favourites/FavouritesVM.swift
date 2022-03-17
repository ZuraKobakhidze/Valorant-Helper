import Foundation
import CoreData
import Combine

protocol FavouritesVMProtocol {
    var itemList: [ViewModel] { get }
    var itemSubject: PassthroughSubject<Bool, Never> { get }
    func fetchData()
    func changeData(to index: Int)
}

class FavouritesVM: FavouritesVMProtocol {
    
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
                if let items = self?.lineUpItems.isEmpty {
                    if items {
                        self?.itemSubject.send(false)
                    } else {
                        self?.itemSubject.send(true)
                    }
                }
            case .failure(let failure):
                self?.itemSubject.send(false)
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
            if itemList.isEmpty  {
                itemSubject.send(false)
            } else {
                itemSubject.send(true)
            }
        } else if index == 1 {
            itemList = crosshairItems as [ViewModel]
            if itemList.isEmpty  {
                itemSubject.send(false)
            } else {
                itemSubject.send(true)
            }
        }
    }
    
}
