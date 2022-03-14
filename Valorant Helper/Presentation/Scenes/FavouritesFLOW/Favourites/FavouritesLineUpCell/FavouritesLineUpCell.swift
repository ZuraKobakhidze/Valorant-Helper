import UIKit

class FavouritesLineUpCell: UITableViewCell {
    
    //MARK: - Views
    
    let mapImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.masksToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = AppColor.darkWhite.color
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let imageBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = AppColor.darkBlack.color
        view.layer.borderColor = AppColor.mediumRed.color.cgColor
        view.layer.borderWidth = 2
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 40
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let imageWhiteBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = AppColor.darkWhite.color
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 35
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let coverImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.layer.cornerRadius = 35
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
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 1
        label.textColor = AppColor.extraBlack.color
        label.font = AppFont.getMedium(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let subTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 1
        label.textColor = AppColor.mediumBlack.color
        label.font = AppFont.getLight(ofSize: 10)
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
        contentView.addSubview(mapImage)
        contentView.addSubview(containerView)
        contentView.addSubview(imageBackgroundView)
        imageBackgroundView.addSubview(imageWhiteBackgroundView)
        imageWhiteBackgroundView.addSubview(coverImage)
        containerView.addSubview(stackView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(subTitleLabel)
        containerView.addSubview(rightArrowImage)
    }
    
    private func buildConstraints() {
        
        NSLayoutConstraint.activate([
        
            mapImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            mapImage.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 65),
            mapImage.heightAnchor.constraint(equalToConstant: 20),
            mapImage.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -25),
            
            containerView.topAnchor.constraint(equalTo: mapImage.bottomAnchor),
            containerView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 65),
            containerView.heightAnchor.constraint(equalToConstant: 50),
            containerView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -25),
            
            imageBackgroundView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageBackgroundView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 25),
            imageBackgroundView.widthAnchor.constraint(equalToConstant: 80),
            imageBackgroundView.heightAnchor.constraint(equalToConstant: 80),
            imageBackgroundView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
            
            imageWhiteBackgroundView.widthAnchor.constraint(equalToConstant: 70),
            imageWhiteBackgroundView.heightAnchor.constraint(equalToConstant: 70),
            imageWhiteBackgroundView.leftAnchor.constraint(equalTo: imageBackgroundView.leftAnchor, constant: 5),
            imageWhiteBackgroundView.topAnchor.constraint(equalTo: imageBackgroundView.topAnchor, constant: 5),
            
            coverImage.widthAnchor.constraint(equalToConstant: 70),
            coverImage.heightAnchor.constraint(equalToConstant: 70),
            coverImage.leftAnchor.constraint(equalTo: imageBackgroundView.leftAnchor, constant: 5),
            coverImage.topAnchor.constraint(equalTo: imageBackgroundView.topAnchor, constant: 5),
            
            stackView.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 50),
            stackView.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -55),
            stackView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            
            rightArrowImage.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            rightArrowImage.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -20),
            rightArrowImage.widthAnchor.constraint(equalToConstant: 15),
            rightArrowImage.heightAnchor.constraint(equalToConstant: 13)
        
        ])
        
    }
    
    //MARK: - Configure
    
    func configure(with vm: LineUpCD) {
        mapImage.loadImageFromURL(urlString: vm.mapIcon ?? "")
        coverImage.loadImageFromURL(urlString: vm.agentImage ?? "")
        titleLabel.text = vm.lineUpName
        subTitleLabel.text = vm.site
    }
    
}
