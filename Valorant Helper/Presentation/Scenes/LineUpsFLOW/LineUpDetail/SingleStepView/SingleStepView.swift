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
    
    lazy var coverImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.masksToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        image.isUserInteractionEnabled = true
        image.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onLookup)))
        return image
    }()
    
    lazy var lookupImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.layer.masksToBounds = true
        image.image = AppAsset.iconLookup
        image.translatesAutoresizingMaskIntoConstraints = false
        image.isUserInteractionEnabled = true
        image.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onLookup)))
        return image
    }()

    //MARK: - Variables

    var onImageAction: ((UIImage) -> Void)?

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
        coverImage.addSubview(lookupImage)
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
            coverImage.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            lookupImage.topAnchor.constraint(equalTo: coverImage.topAnchor, constant: 25),
            lookupImage.rightAnchor.constraint(equalTo: coverImage.rightAnchor, constant: -25),
            lookupImage.widthAnchor.constraint(equalToConstant: 30),
            lookupImage.heightAnchor.constraint(equalToConstant: 30)
        
        ])
        
    }

    //MARK: - Setup

    // Your Setup Methods Here

    //MARK: - Configure

    func configure(with vm: LineUpStep?, onImageAction: ((UIImage) -> Void)?) {
        titleLabel.text = "\("#Step".localized()) \(vm?.stepNumber ?? 0)"
//        coverImage.loadImageFromURL(urlString: vm?.stepImage ?? "")
        coverImage.loadBigImageFromURL(urlString: vm?.stepImage ?? "")
        self.onImageAction = onImageAction
    }

    //MARK: - Actions

    @objc func onLookup() {
        guard let image = coverImage.image else { return }
        onImageAction?(image)
    }
    
}
