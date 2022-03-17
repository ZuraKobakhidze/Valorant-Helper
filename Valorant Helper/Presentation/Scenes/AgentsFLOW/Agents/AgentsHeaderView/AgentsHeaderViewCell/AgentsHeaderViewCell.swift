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
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseIn) { [weak self] in
                self?.titleLabel.textColor = AppColor.mediumRed.color
                self?.underlineView.isHidden = false
                self?.titleLabel.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
                self?.underlineView.transform = CGAffineTransform(scaleX: 1.1, y: 1)
            } completion: { _ in
                UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseOut) { [weak self] in
                    self?.titleLabel.transform = CGAffineTransform.identity
                    self?.underlineView.transform = CGAffineTransform.identity
                }
            }

        } else {
            titleLabel.textColor = AppColor.lightWhite.color
            underlineView.isHidden = true
        }
    }
    
}
