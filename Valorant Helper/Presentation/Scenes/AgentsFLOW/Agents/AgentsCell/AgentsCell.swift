import UIKit

class AgentsCell: UICollectionViewCell {
    
    //MARK: - Views
    
    let backgroundImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.layer.masksToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let coverImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.layer.masksToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = AppColor.mediumRed.color
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.spacing = 2
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColor.lightWhite.color
        label.font = AppFont.getVALORANT(ofSize: 14)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let roleLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColor.darkWhite.color
        label.font = AppFont.getLight(ofSize: 10)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let roleImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.layer.masksToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    //MARK: - Functions
    
    override func layoutSubviews() {
        super.layoutSubviews()

        buildSubviews()
        buildConstraints()
    }
    
    //MARK: - Build
    
    private func buildSubviews() {
        contentView.addSubview(backgroundImage)
        contentView.addSubview(coverImage)
        contentView.addSubview(containerView)
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(roleLabel)
        contentView.addSubview(roleImage)
    }
    
    private func buildConstraints() {
        
        NSLayoutConstraint.activate([
        
            backgroundImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            backgroundImage.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            backgroundImage.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            
            coverImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            coverImage.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            coverImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            coverImage.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            
            containerView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            containerView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 40),
            
            stackView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            stackView.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 10),
            stackView.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -10),
            
            roleImage.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            roleImage.centerYAnchor.constraint(equalTo: roleLabel.centerYAnchor),
            roleImage.widthAnchor.constraint(equalToConstant: 10),
            roleImage.heightAnchor.constraint(equalToConstant: 10)
        
        ])
        
    }
    
    //MARK: - Configure
    
    func configure(with vm: AgentsCellVM?) {
        guard let vm = vm else { return }
        backgroundImage.loadImageFromURL(urlString: vm.background ?? "")
        coverImage.loadImageFromURL(urlString: vm.bustPortrait ?? "")
        roleImage.loadImageFromURL(urlString: vm.roleIcon ?? "")
        nameLabel.text = vm.displayName
        roleLabel.text = vm.roleName
    }
    
}
