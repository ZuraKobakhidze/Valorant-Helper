import UIKit

class AgentsHeaderViewCell: UICollectionViewCell {
    
    //MARK: - Views
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = AppFont.getMedium(ofSize: 14)
        label.textAlignment = .center
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let underlineView: UIView = {
        let view = UIView()
        view.backgroundColor = AppColor.mediumRed.color
        view.isHidden = true
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
        contentView.addSubview(titleLabel)
        contentView.addSubview(underlineView)
    }
    
    private func buildConstraints() {
        
        NSLayoutConstraint.activate([
        
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            
            underlineView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            underlineView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            underlineView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            underlineView.heightAnchor.constraint(equalToConstant: 2),
            underlineView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        
        ])
        
    }
    
    //MARK: - Configure
    
    func configure(with vm: AgentsHeaderViewCellVM) {
        titleLabel.text = vm.title.getString
        if vm.isOn {
            titleLabel.textColor = AppColor.mediumRed.color
            underlineView.isHidden = false
        } else {
            titleLabel.textColor = AppColor.lightWhite.color
            underlineView.isHidden = true
        }
    }
    
}
