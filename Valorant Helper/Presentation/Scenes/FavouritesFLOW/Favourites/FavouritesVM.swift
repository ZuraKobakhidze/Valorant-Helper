import Foundation

class FavouritesVM {
    
    let lineUpsCoreDataManager: CoreDataManagerProtocol = CrosshairCoreDataManager()
    
    func read() {
        lineUpsCoreDataManager.read()
    }
    
}
