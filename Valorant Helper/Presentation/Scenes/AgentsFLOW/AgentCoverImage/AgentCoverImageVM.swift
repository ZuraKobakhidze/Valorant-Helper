import Foundation

struct AgentCoverImageVM {
    
    var backgroundImage: String?
    var coverImage: String?
    
    var itemList: [AgentCoverImageCellVM] = [
        AgentCoverImageCellVM(color: .darkBlack, isSelected: true),
        AgentCoverImageCellVM(color: .extraBlack, isSelected: false),
        AgentCoverImageCellVM(color: .darkWhite, isSelected: false),
        AgentCoverImageCellVM(color: .darkBlue, isSelected: false),
        AgentCoverImageCellVM(color: .darkBrown, isSelected: false),
        AgentCoverImageCellVM(color: .darkGreen, isSelected: false),
        AgentCoverImageCellVM(color: .darkRed, isSelected: false),
        AgentCoverImageCellVM(color: .mediumRed, isSelected: false),
    ]
    
    mutating func changeItemList(on indexPath: IndexPath, completion: @escaping ((Bool) -> Void)) {
        if !itemList[indexPath.row].isSelected {
            for i in 0..<itemList.count {
                itemList[i].isSelected = false
            }
            itemList[indexPath.row].isSelected = true
            completion(true)
        } else {
            completion(false)
        }
    }
    
}
