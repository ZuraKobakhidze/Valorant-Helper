import UIKit

class AgentCoverImageCell: UICollectionViewCell {
    
    //MARK: - Views
    
    let outerView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 2
        view.layer.shadowColor = AppColor.extraBlack.color.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowOpacity = 0.5
        view.layer.shadowRadius = 3
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let colorView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 2
        view.layer.borderColor = AppColor.mediumWhite.color.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //MARK: - Functions
    
    override func layoutSubviews() {
        super.layoutSubviews()

        buildSubviews()
        buildConstraints()
    }
    
    //MARK: - Build
    
    private func buildSubviews() {
        contentView.addSubview(outerView)
        outerView.addSubview(colorView)
    }
    
    private func buildConstraints() {
        
        NSLayoutConstraint.activate([
        
            outerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 3),
            outerView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -3),
            outerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -3),
            outerView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 3),
            
            colorView.topAnchor.constraint(equalTo: outerView.topAnchor, constant: 8),
            colorView.rightAnchor.constraint(equalTo: outerView.rightAnchor, constant: -8),
            colorView.bottomAnchor.constraint(equalTo: outerView.bottomAnchor, constant: -8),
            colorView.leftAnchor.constraint(equalTo: outerView.leftAnchor, constant: 8)
        
        ])
        
        
    }
    
    //MARK: - Configure
    
    func configure(with vm: AgentCoverImageCellVM?) {
        guard let vm = vm else { return }
        colorView.backgroundColor = vm.color.color
        if vm.isSelected {
            outerView.layer.borderColor = AppColor.mediumRed.color.cgColor
        } else {
            outerView.layer.borderColor = AppColor.lightWhite.color.cgColor
        }
    }
    
}
