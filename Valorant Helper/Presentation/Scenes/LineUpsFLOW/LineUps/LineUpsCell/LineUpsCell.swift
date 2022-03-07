import UIKit

class LineUpsCell: UITableViewCell {
    
    //MARK: - Views
    
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = AppColor.darkWhite.color
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let agentImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.layer.masksToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 3
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColor.extraBlack.color
        label.font = AppFont.getVALORANT(ofSize: 16)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let roleLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColor.mediumBlack.color
        label.font = AppFont.getLight(ofSize: 10)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let rightArrowImage: UIImageView = {
        let image = UIImageView()
        image.image = AppAsset.iconRightArrow
        image.contentMode = .scaleAspectFit
        image.layer.masksToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let bottomLineView: UIView = {
        let view = UIView()
        view.backgroundColor = AppColor.mediumRed.color
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        buildSubviews()
        buildConstraints()
        selectionStyle = .none
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Build
    
    private func buildSubviews() {
        contentView.addSubview(containerView)
        containerView.addSubview(agentImage)
        containerView.addSubview(stackView)
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(roleLabel)
        containerView.addSubview(rightArrowImage)
        containerView.addSubview(bottomLineView)
    }
    
    private func buildConstraints() {
        
        NSLayoutConstraint.activate([
        
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 25),
            containerView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -25),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
            
            agentImage.topAnchor.constraint(equalTo: containerView.topAnchor),
            agentImage.leftAnchor.constraint(equalTo: containerView.leftAnchor),
            agentImage.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            agentImage.widthAnchor.constraint(equalToConstant: 60),
            agentImage.heightAnchor.constraint(equalToConstant: 60),
            
            stackView.centerYAnchor.constraint(equalTo: agentImage.centerYAnchor),
            stackView.leftAnchor.constraint(equalTo: agentImage.rightAnchor, constant: 20),
            stackView.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -50),
            
            rightArrowImage.centerYAnchor.constraint(equalTo: agentImage.centerYAnchor),
            rightArrowImage.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -20),
            rightArrowImage.widthAnchor.constraint(equalToConstant: 15),
            rightArrowImage.heightAnchor.constraint(equalToConstant: 13),
            
            bottomLineView.leftAnchor.constraint(equalTo: containerView.leftAnchor),
            bottomLineView.rightAnchor.constraint(equalTo: containerView.rightAnchor),
            bottomLineView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            bottomLineView.heightAnchor.constraint(equalToConstant: 5)
        
        ])
        
    }
    
    //MARK: - Configure
    
    func configure(with vm: LineUpsModel?) {
        agentImage.loadImageFromURL(urlString: vm?.displayIcon ?? "")
        nameLabel.text = vm?.displayName
        roleLabel.text = vm?.role?.displayName
    }
    
}
