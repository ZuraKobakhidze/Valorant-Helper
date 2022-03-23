import UIKit

class LineUpImageDetailVC: UIViewController {
    
    //MARK: - Views
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = AppColor.darkBlack.color
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isUserInteractionEnabled = true
        scrollView.delegate = self
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 4.0
        return scrollView
    }()

    lazy var coverImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.layer.masksToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        image.isUserInteractionEnabled = true
        return image
    }()
    
    lazy var closeImage: UIImageView = {
        let image = UIImageView()
        image.image = AppAsset.iconClose
        image.contentMode = .scaleAspectFit
        image.layer.masksToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        image.isUserInteractionEnabled = true
        image.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onClose)))
        return image
    }()

    //MARK: - Variables

    // Your Variables Here

    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = AppColor.darkBlack.color
        view.transform = CGAffineTransform(rotationAngle: .pi/2)
        buildSubviews()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        buildConstraints()
    }
    
    //MARK: - Build

    private func buildSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(coverImage)
        view.addSubview(closeImage)
    }

    private func buildConstraints() {

        NSLayoutConstraint.activate([
            
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        
            coverImage.topAnchor.constraint(equalTo: scrollView.topAnchor),
            coverImage.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            coverImage.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
            coverImage.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            coverImage.widthAnchor.constraint(equalToConstant: PublicConstants.screenHeight),
            coverImage.heightAnchor.constraint(equalToConstant: PublicConstants.screenWidth),
            
            closeImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 25),
            closeImage.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -PublicConstants.bottomPadding-75),
            closeImage.widthAnchor.constraint(equalToConstant: 40),
            closeImage.heightAnchor.constraint(equalToConstant: 40)
        
        ])
        
    }

    //MARK: - Setup

    // Your Setup Methods Here

    //MARK: - Configure

    func configure(with image: UIImage?) {
        coverImage.image = image
    }

    //MARK: - Actions

    @objc func onClose() {
        dismiss(animated: true)
    }
    
}

extension LineUpImageDetailVC: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        coverImage
    }
    
}
