import UIKit

class SiteLineUpsCell: UITableViewCell {
    
    //MARK: - Views
    
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
        view.layer.cornerRadius = 30
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let imageWhiteBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = AppColor.darkWhite.color
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 25
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let coverImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.layer.cornerRadius = 25
        image.layer.masksToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
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
        contentView.addSubview(containerView)
        contentView.addSubview(imageBackgroundView)
        imageBackgroundView.addSubview(imageWhiteBackgroundView)
        imageWhiteBackgroundView.addSubview(coverImage)
        containerView.addSubview(titleLabel)
        containerView.addSubview(rightArrowImage)
    }
    
    private func buildConstraints() {
        
        NSLayoutConstraint.activate([
        
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 55),
            containerView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -25),
            containerView.heightAnchor.constraint(equalToConstant: 60),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
            
            imageBackgroundView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageBackgroundView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 25),
            imageBackgroundView.widthAnchor.constraint(equalToConstant: 60),
            imageBackgroundView.heightAnchor.constraint(equalToConstant: 60),
            
            imageWhiteBackgroundView.widthAnchor.constraint(equalToConstant: 50),
            imageWhiteBackgroundView.heightAnchor.constraint(equalToConstant: 50),
            imageWhiteBackgroundView.leftAnchor.constraint(equalTo: imageBackgroundView.leftAnchor, constant: 5),
            imageWhiteBackgroundView.topAnchor.constraint(equalTo: imageBackgroundView.topAnchor, constant: 5),
            
            coverImage.widthAnchor.constraint(equalToConstant: 50),
            coverImage.heightAnchor.constraint(equalToConstant: 50),
            coverImage.leftAnchor.constraint(equalTo: imageBackgroundView.leftAnchor, constant: 5),
            coverImage.topAnchor.constraint(equalTo: imageBackgroundView.topAnchor, constant: 5),
            
            titleLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 40),
            titleLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -55),
            titleLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            
            rightArrowImage.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            rightArrowImage.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -20),
            rightArrowImage.widthAnchor.constraint(equalToConstant: 15),
            rightArrowImage.heightAnchor.constraint(equalToConstant: 13)
        
        ])
        
    }
    
    //MARK: - Configure
    
    func configure(with vm: SiteLineUpsCellVM?) {
        coverImage.loadImageFromURL(urlString: vm?.agentImage ?? "")
        titleLabel.text = vm?.item?.lineUpName
    }
    
}
