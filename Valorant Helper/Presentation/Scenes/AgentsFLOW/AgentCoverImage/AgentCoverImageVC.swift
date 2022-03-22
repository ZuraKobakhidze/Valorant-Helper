import UIKit

class AgentCoverImageVC: UIViewController {
    
    //MARK: - Views

    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Preview".localized()
        label.font = AppFont.getMedium(ofSize: 18)
        label.textColor = AppColor.lightWhite.color
        label.textAlignment = .center
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var closeImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.layer.masksToBounds = true
        image.image = AppAsset.iconClose
        image.translatesAutoresizingMaskIntoConstraints = false
        image.isUserInteractionEnabled = true
        image.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onClose)))
        return image
    }()
    
    lazy var downloadImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.layer.masksToBounds = true
        image.image = AppAsset.iconDownload
        image.translatesAutoresizingMaskIntoConstraints = false
        image.isUserInteractionEnabled = true
        image.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onDownload)))
        return image
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = AppColor.mediumRed.color
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = AppColor.darkBlack.color
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let backgroundImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.layer.masksToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let agentImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.layer.masksToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = AppColor.darkBlack.color
        buildSubviews()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        buildConstraints()
    }

    //MARK: - Build

    private func buildSubviews() {
        view.addSubview(titleLabel)
        view.addSubview(closeImage)
        view.addSubview(downloadImage)
        view.addSubview(separatorView)
        view.addSubview(containerView)
        containerView.addSubview(backgroundImage)
        backgroundImage.addSubview(agentImage)
    }

    private func buildConstraints() {
        
        NSLayoutConstraint.activate([
        
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: view.safeAreaInsets.top+5),
            titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 70),
            titleLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -70),
            titleLabel.heightAnchor.constraint(equalToConstant: 50),
            
            closeImage.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -25),
            closeImage.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            closeImage.widthAnchor.constraint(equalToConstant: 30),
            closeImage.heightAnchor.constraint(equalToConstant: 30),
            
            downloadImage.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 25),
            downloadImage.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            downloadImage.widthAnchor.constraint(equalToConstant: 30),
            downloadImage.heightAnchor.constraint(equalToConstant: 30),
            
            separatorView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            separatorView.leftAnchor.constraint(equalTo: view.leftAnchor),
            separatorView.rightAnchor.constraint(equalTo: view.rightAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 2),
            
            containerView.topAnchor.constraint(equalTo: separatorView.bottomAnchor),
            containerView.leftAnchor.constraint(equalTo: view.leftAnchor),
            containerView.rightAnchor.constraint(equalTo: view.rightAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -15),

            backgroundImage.topAnchor.constraint(equalTo: containerView.topAnchor),
            backgroundImage.leftAnchor.constraint(equalTo: containerView.leftAnchor),
            backgroundImage.rightAnchor.constraint(equalTo: containerView.rightAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),

            agentImage.topAnchor.constraint(equalTo: backgroundImage.topAnchor),
            agentImage.leftAnchor.constraint(equalTo: backgroundImage.leftAnchor),
            agentImage.rightAnchor.constraint(equalTo: backgroundImage.rightAnchor),
            agentImage.bottomAnchor.constraint(equalTo: backgroundImage.bottomAnchor)
        
        ])

    }

    //MARK: - Configure

    func configure(with vm: AgentCoverImageVM?) {
        backgroundImage.loadImageFromURL(urlString: vm?.backgroundImage ?? "")
        agentImage.loadImageFromURL(urlString: vm?.coverImage ?? "")
    }

    //MARK: - Actions

    @objc func onClose() {
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut) { [weak self] in
            self?.closeImage.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        } completion: { [weak self] _ in
            self?.dismiss(animated: true)
        }
    }
    
    @objc func onDownload() {
        UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseOut) { [weak self] in
            self?.downloadImage.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        } completion: { _ in
            UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseIn) { [weak self] in
                self?.downloadImage.transform = CGAffineTransform.identity
            } completion: { [weak self] _ in
                guard let image = self?.containerView.asImage() else { return }
                UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
            }
        }
    }
    
}
