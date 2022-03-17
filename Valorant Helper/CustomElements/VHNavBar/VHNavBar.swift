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
    
    lazy var centerItemImageView: UIImageView = {
        let image = UIImageView()
        image.image = AppAsset.logoValorantHelper
        image.contentMode = .scaleAspectFit
        image.layer.masksToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        image.alpha = 0
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
    }

    private func buildConstraints() {
        
        NSLayoutConstraint.activate( [
        
            containerView.topAnchor.constraint(equalTo: self.topAnchor),
            containerView.rightAnchor.constraint(equalTo: self.rightAnchor),
            containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            containerView.leftAnchor.constraint(equalTo: self.leftAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 60),
            
            leftItemImageView.widthAnchor.constraint(equalToConstant: 24),
            leftItemImageView.heightAnchor.constraint(equalToConstant: 20),
            leftItemImageView.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 25),
            leftItemImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
        
        ])
        
    }

    //MARK: - Setup

    private func setupWithLogo() {
        
        containerView.addSubview(centerItemImageView)
        
        NSLayoutConstraint.activate( [
            
            centerItemImageView.widthAnchor.constraint(equalToConstant: 43),
            centerItemImageView.heightAnchor.constraint(equalToConstant: 38),
            centerItemImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            centerItemImageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
        
        ])
        
        logoAnimation()
        
    }
    
    private func setupWithAgent(agentImage: String) {
        
        let borderLineView: UIView = {
            let view = UIView()
            view.backgroundColor = .clear
            view.layer.borderWidth = 1
            view.layer.cornerRadius = 22
            view.layer.borderColor = AppColor.mediumRed.color.cgColor
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
        
        let imageBackgroundView: UIView = {
            let view = UIView()
            view.backgroundColor = AppColor.darkWhite.color
            view.layer.cornerRadius = 20
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
        
        let agentImage: UIImageView = {
            let image = UIImageView()
            image.loadImageFromURL(urlString: agentImage)
            image.contentMode = .scaleAspectFit
            image.layer.cornerRadius = 20
            image.layer.masksToBounds = true
            image.translatesAutoresizingMaskIntoConstraints = false
            return image
        }()
        
        containerView.addSubview(borderLineView)
        borderLineView.addSubview(imageBackgroundView)
        imageBackgroundView.addSubview(agentImage)
        
        NSLayoutConstraint.activate([
        
            borderLineView.widthAnchor.constraint(equalToConstant: 44),
            borderLineView.heightAnchor.constraint(equalToConstant: 44),
            borderLineView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            borderLineView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            
            imageBackgroundView.widthAnchor.constraint(equalToConstant: 40),
            imageBackgroundView.heightAnchor.constraint(equalToConstant: 40),
            imageBackgroundView.centerYAnchor.constraint(equalTo: borderLineView.centerYAnchor),
            imageBackgroundView.centerXAnchor.constraint(equalTo: borderLineView.centerXAnchor),
            
            agentImage.widthAnchor.constraint(equalToConstant: 40),
            agentImage.heightAnchor.constraint(equalToConstant: 40),
            agentImage.centerYAnchor.constraint(equalTo: imageBackgroundView.centerYAnchor),
            agentImage.centerXAnchor.constraint(equalTo: imageBackgroundView.centerXAnchor),
            
        ])
        
    }
    
    private func logoAnimation() {
        
        centerItemImageView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut) { [weak self] in
            self?.centerItemImageView.alpha = 1
            self?.centerItemImageView.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        } completion: { _ in
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveLinear) { [weak self] in
                self?.centerItemImageView.transform = CGAffineTransform.identity
            }
        }
        
    }

    //MARK: - Configure

    func configure(with vm: VHNavBarVM) {
        leftAction = vm.leftAction
        switch vm.navBarStyle {
            case .withLogo:
                setupWithLogo()
            case .withAgentImage(agentImage: let image):
                setupWithAgent(agentImage: image)
        }
    }

    //MARK: - Actions

    @objc func onLeft() {
        leftAction?()
    }
    
}
