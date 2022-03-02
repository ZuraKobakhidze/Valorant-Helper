import UIKit

class LineUpsMapsCell: UITableViewCell {
    
    //MARK: - Views
    
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = AppColor.darkWhite.color
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let titleTextLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColor.extraBlack.color
        label.font = AppFont.getRegular(ofSize: 12)
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
        contentView.addSubview(containerView)
        containerView.addSubview(titleTextLabel)
        containerView.addSubview(rightArrowImage)
        contentView.addSubview(underlineView)
    }
    
    private func buildConstraints() {
        
        NSLayoutConstraint.activate([
        
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 25),
            containerView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -25),
            containerView.heightAnchor.constraint(equalToConstant: 30),
            
            titleTextLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 20),
            titleTextLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -42),
            titleTextLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            
            rightArrowImage.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -20),
            rightArrowImage.widthAnchor.constraint(equalToConstant: 10),
            rightArrowImage.heightAnchor.constraint(equalToConstant: 9),
            rightArrowImage.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            
            underlineView.topAnchor.constraint(equalTo: containerView.bottomAnchor),
            underlineView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 25),
            underlineView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -25),
            underlineView.heightAnchor.constraint(equalToConstant: 2),
            underlineView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        
        ])
        
    }
    
    //MARK: - Configure
    
    func configure(with vm: LineUpsMapsSiteModel?) {
        titleTextLabel.text = vm?.siteName
    }
    
}
