import UIKit

class SingleStepView: UIView {
    
    //MARK: - Views

    let titleView: UIView = {
        let view = UIView()
        view.backgroundColor = AppColor.darkWhite.color
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColor.extraBlack.color
        label.font = AppFont.getBold(ofSize: 14)
        label.numberOfLines = 1
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let coverImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.masksToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    //MARK: - Variables

    // Your Variables Here

    //MARK: - Init

    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }

    //MARK: - Functions

    override func layoutSubviews() {
        super.layoutSubviews()
        
        buildSubviews()
        buildConstraints()
    }

    //MARK: - Build

    private func buildSubviews() {
        addSubview(titleView)
        titleView.addSubview(titleLabel)
        addSubview(coverImage)
    }

    private func buildConstraints() {

        NSLayoutConstraint.activate([
        
            titleView.topAnchor.constraint(equalTo: self.topAnchor),
            titleView.leftAnchor.constraint(equalTo: self.leftAnchor),
            titleView.rightAnchor.constraint(equalTo: self.rightAnchor),
            titleView.heightAnchor.constraint(equalToConstant: 30),
            
            titleLabel.leftAnchor.constraint(equalTo: titleView.leftAnchor, constant: 25),
            titleLabel.rightAnchor.constraint(equalTo: titleView.rightAnchor, constant: -25),
            titleLabel.centerYAnchor.constraint(equalTo: titleView.centerYAnchor),
            
            coverImage.topAnchor.constraint(equalTo: titleView.bottomAnchor),
            coverImage.leftAnchor.constraint(equalTo: self.leftAnchor),
            coverImage.rightAnchor.constraint(equalTo: self.rightAnchor),
            coverImage.heightAnchor.constraint(equalToConstant: (PublicConstants.screenWidth/16)*9),
            coverImage.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        
        ])
        
    }

    //MARK: - Setup

    // Your Setup Methods Here

    //MARK: - Configure

    func configure(with vm: LineUpStep?) {
        titleLabel.text = "\("#Step".localized()) \(vm?.stepNumber ?? 0)"
        coverImage.loadImageFromURL(urlString: vm?.stepImage ?? "")
    }

    //MARK: - Actions

    // Your Actions Here
    
}
