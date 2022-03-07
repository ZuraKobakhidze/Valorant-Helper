import Foundation
import Combine

protocol LineUpsMapVMProtocol {
    var agentName: String { get }
    var agentImage: String { get }
    var itemList: [LineUpsMapList] { get }
    var itemSubject: PassthroughSubject<Bool, Never> { get }
    var sectionReloadSubject: PassthroughSubject<Int, Never> { get }
    init(agentName: String, agentImage: String)
    func getItemList()
    func collapseItems(on section: Int) 
}

class LineUpsMapVM: LineUpsMapVMProtocol {
    
    var agentName: String
    var agentImage: String
    var itemList: [LineUpsMapList] = [LineUpsMapList]()
    var itemSubject = PassthroughSubject<Bool, Never>()
    var sectionReloadSubject = PassthroughSubject<Int, Never>()
    var hiddenSections = Set<Int>()
    
    required init(agentName: String, agentImage: String) {
        self.agentName = agentName
        self.agentImage = agentImage
    }
    
    func getItemList() {
        
        NetworkEngine.shared.request(endPoint: LineUpsEndpoint.getMapsForAgent) { [weak self] (result: Result<[LineUpsMapsModel], Error>) in
            switch result {
                case .success(let success):
                    self?.itemList = success.map { LineUpsMapList(item: $0, isCollapsed: true) }
                    self?.itemSubject.send(true)
                case .failure(let failure):
                    print(failure.localizedDescription)
            }
        }
        
    }
    
    func collapseItems(on section: Int) {
        itemList[section].isCollapsed.toggle()
        sectionReloadSubject.send(section)
    }
    
}

struct LineUpsMapList {
    let item: LineUpsMapsModel?
    var isCollapsed = true
}
