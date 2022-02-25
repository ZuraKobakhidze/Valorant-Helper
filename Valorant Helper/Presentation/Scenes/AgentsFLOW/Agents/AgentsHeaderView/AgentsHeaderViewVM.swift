import UIKit
import Combine

protocol AgentsHeaderViewVMProtocol {
    var itemList: [AgentsHeaderViewCellVM] { get set }
    var itemSubject: PassthroughSubject<AgentsDataType, Never> { get set }
    func changeItemListIsOn(on index: IndexPath)
    func widthForLabel(to index: IndexPath) -> CGFloat
}

class AgentsHeaderViewVM: AgentsHeaderViewVMProtocol {
    
    var itemList = [
        AgentsHeaderViewCellVM(title: .all, isOn: true),
        AgentsHeaderViewCellVM(title: .initiator, isOn: false),
        AgentsHeaderViewCellVM(title: .duelist, isOn: false),
        AgentsHeaderViewCellVM(title: .controller, isOn: false),
        AgentsHeaderViewCellVM(title: .sentinel, isOn: false)
    ]
    
    var itemSubject = PassthroughSubject<AgentsDataType, Never>()
    
    func changeItemListIsOn(on index: IndexPath) {
        for i in 0..<itemList.count {
            if itemList[i].isOn == true {
                itemList[i].isOn = false
                break
            } else {
                continue
            }
        }
        itemList[index.row].isOn = true
        itemSubject.send(itemList[index.row].title)
    }
    
    func widthForLabel(to index: IndexPath) -> CGFloat {
        
        let label = UILabel()
        label.text = itemList[index.row].title.getString
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = AppFont.getMedium(ofSize: 14)
        label.textAlignment = .center
        label.numberOfLines = 1
        label.sizeToFit()
        
        return label.frame.width
        
    }
    
}
