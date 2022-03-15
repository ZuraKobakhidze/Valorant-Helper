import UIKit

class CrosshairsCell: UITableViewCell {
    
    //MARK: - Views
    
    let coverImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.masksToBounds = true
        image.layer.borderColor = AppColor.darkWhite.color.cgColor
        image.layer.borderWidth = 5
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = AppColor.darkWhite.color
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColor.extraBlack.color
        label.font = AppFont.getMedium(ofSize: 14)
        label.numberOfLines = 1
        label.textAlignment = .left
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
        contentView.addSubview(coverImage)
        contentView.addSubview(containerView)
        containerView.addSubview(nameLabel)
        containerView.addSubview(rightArrowImage)
        contentView.addSubview(bottomLineView)
    }
    
    private func buildConstraints() {
        
        NSLayoutConstraint.activate([
        
            coverImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            coverImage.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 25),
            coverImage.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -25),
            coverImage.heightAnchor.constraint(equalToConstant: ((PublicConstants.screenWidth-50)/16)*9),
            
            containerView.topAnchor.constraint(equalTo: coverImage.bottomAnchor),
            containerView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 25),
            containerView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -25),
            containerView.heightAnchor.constraint(equalToConstant: 40),
            
            nameLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 10),
            nameLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -45),
            nameLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            
            rightArrowImage.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            rightArrowImage.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -20),
            rightArrowImage.widthAnchor.constraint(equalToConstant: 15),
            rightArrowImage.heightAnchor.constraint(equalToConstant: 13),
            
            bottomLineView.topAnchor.constraint(equalTo: containerView.bottomAnchor),
            bottomLineView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 25),
            bottomLineView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -25),
            bottomLineView.heightAnchor.constraint(equalToConstant: 5),
            bottomLineView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15)
        
        ])
        
    }
    
    //MARK: - Configure
    
    func configure(with vm: ViewModel) {
        
        if let vm = vm as? CrosshairsListModel {
            coverImage.loadImageFromURL(urlString: vm.coverImage ?? "")
            nameLabel.text = vm.name
            return
        }
        
        if let vm = vm as? CrosshairCD {
            coverImage.loadImageFromURL(urlString: vm.coverImage ?? "")
            nameLabel.text = vm.name
            return
        }
        
    }
    
}
