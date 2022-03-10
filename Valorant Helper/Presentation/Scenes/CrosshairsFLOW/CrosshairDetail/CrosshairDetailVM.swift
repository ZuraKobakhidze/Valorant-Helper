import Foundation

protocol CrosshairDetailVMProtocol {
    var item: CrosshairsModel? { get }
    init(item: CrosshairsModel?)
}

class CrosshairDetailVM: CrosshairDetailVMProtocol {
    
    var item: CrosshairsModel?
    
    required init(item: CrosshairsModel?) {
        self.item = item
    }
    
}
