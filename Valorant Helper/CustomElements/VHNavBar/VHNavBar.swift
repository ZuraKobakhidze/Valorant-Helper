import UIKit

class VHNavBar: UIView {
    
    //MARK: - Views
    
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = AppColor.darkBlack.color
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var leftItemImageView: UIImageView = {
        let image = UIImageView()
        image.image = AppAsset.iconBackButton
        image.contentMode = .scaleAspectFit
        image.layer.masksToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        image.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onLeft)))
        image.isUserInteractionEnabled = true
        return image
    }()
    
    let centerItemImageView: UIImageView = {
        let image = UIImageView()
        image.image = AppAsset.logoValorantHelper
        image.contentMode = .scaleAspectFit
        image.layer.masksToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    //MARK: - Variables

    var leftAction: (() -> Void)?

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
        addSubview(containerView)
        containerView.addSubview(leftItemImageView)
        containerView.addSubview(centerItemImageView)
    }

    private func buildConstraints() {
        
        NSLayoutConstraint.activate( [
        
            containerView.topAnchor.constraint(equalTo: self.topAnchor),
            containerView.rightAnchor.constraint(equalTo: self.rightAnchor),
            containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            containerView.leftAnchor.constraint(equalTo: self.leftAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 60),
            
            centerItemImageView.widthAnchor.constraint(equalToConstant: 43),
            centerItemImageView.heightAnchor.constraint(equalToConstant: 38),
            centerItemImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            centerItemImageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            
            leftItemImageView.widthAnchor.constraint(equalToConstant: 24),
            leftItemImageView.heightAnchor.constraint(equalToConstant: 20),
            leftItemImageView.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 25),
            leftItemImageView.centerYAnchor.constraint(equalTo: centerItemImageView.centerYAnchor),
        
        ])
        
    }

    //MARK: - Setup

    // Your Setup Methods Here

    //MARK: - Configure

    func configure(with vm: VHNavBarVM) {
        leftAction = vm.leftAction
    }

    //MARK: - Actions

    @objc func onLeft() {
        leftAction?()
    }
    
}
