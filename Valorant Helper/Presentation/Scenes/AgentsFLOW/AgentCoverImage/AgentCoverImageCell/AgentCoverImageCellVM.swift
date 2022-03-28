import Foundation

class AgentCoverImageCellVM {
    let color: AppColor
    var isSelected: Bool
    init(color: AppColor, isSelected: Bool) {
        self.color = color
        self.isSelected = isSelected
    }
}
