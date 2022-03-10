import UIKit

class LineUpsMapsSectionCell: UITableViewCell {
    
    //MARK: - Views
    
    let coverImage: UIImageView = {
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
    
    let titleTextLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColor.extraBlack.color
        label.font = AppFont.getMedium(ofSize: 14)
        label.numberOfLines = 1
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let collapseImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.layer.masksToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let underlineView: UIView = {
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
        addSubview(coverImage)
        addSubview(containerView)
        containerView.addSubview(titleTextLabel)
        containerView.addSubview(collapseImage)
        addSubview(underlineView)
    }

    private func buildConstraints() {
        
        NSLayoutConstraint.activate([
        
            coverImage.topAnchor.constraint(equalTo: self.topAnchor),
            coverImage.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 25),
            coverImage.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -25),
            coverImage.heightAnchor.constraint(greaterThanOrEqualToConstant: 80),
            coverImage.heightAnchor.constraint(equalToConstant: (PublicConstants.screenWidth-50)/5),
            
            containerView.topAnchor.constraint(equalTo: coverImage.bottomAnchor),
            containerView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 25),
            containerView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -25),
            containerView.heightAnchor.constraint(equalToConstant: 40),
            
            titleTextLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 20),
            titleTextLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -57),
            titleTextLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            
            collapseImage.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -20),
            collapseImage.widthAnchor.constraint(equalToConstant: 12),
            collapseImage.heightAnchor.constraint(equalToConstant: 6),
            collapseImage.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            
            underlineView.topAnchor.constraint(equalTo: containerView.bottomAnchor),
            underlineView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 25),
            underlineView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -25),
            underlineView.heightAnchor.constraint(equalToConstant: 5),
            underlineView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
            
        ])

    }
    
    //MARK: - Configure
    
    func configure(with vm: LineUpsMapList?) {
        coverImage.loadImageFromURL(urlString: vm?.item?.listViewIcon ?? "")
        titleTextLabel.text = vm?.item?.displayName
        if vm?.isCollapsed ?? true {
            titleTextLabel.textColor = AppColor.extraBlack.color
            collapseImage.image = AppAsset.iconCollapsed
        } else {
            titleTextLabel.textColor = AppColor.mediumRed.color
            collapseImage.image = AppAsset.iconNotCollapsed
        }
    }
    
}
