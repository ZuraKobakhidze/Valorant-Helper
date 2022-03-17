import UIKit
import Combine

class CrosshairDetailVC: UIViewController {
    
    //MARK: - Views

    let navBar = VHNavBar()
    
    lazy var favouriteImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.layer.masksToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        image.isUserInteractionEnabled = true
        image.isHidden = true
        image.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onFavourite)))
        return image
    }()
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = AppColor.darkBlack.color
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
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
        label.font = AppFont.getMedium(ofSize: 18)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let bottomLineView: UIView = {
        let view = UIView()
        view.backgroundColor = AppColor.mediumRed.color
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.distribution = .fillEqually
        stackView.layer.borderWidth = 2
        stackView.layer.borderColor = AppColor.darkWhite.color.cgColor
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let emptyBackgroundView = EmptyBackgroundView()

    //MARK: - Variables

    var viewModel: CrosshairDetailVMProtocol?
    var cancellableList: Set<AnyCancellable> = []

    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = AppColor.darkBlack.color
        buildSubviews()
        setupGestures()
        setupViewModel()
        configureNavBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        viewModel?.checkIfFavourite()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        buildConstraints()
    }

    //MARK: - Build

    private func buildSubviews() {
        view.addSubview(navBar)
        view.addSubview(favouriteImage)
        view.addSubview(scrollView)
        scrollView.addSubview(coverImage)
        scrollView.addSubview(containerView)
        containerView.addSubview(nameLabel)
        scrollView.addSubview(bottomLineView)
        scrollView.addSubview(stackView)
        view.addSubview(emptyBackgroundView)
    }

    private func buildConstraints() {

        NSLayoutConstraint.activate([
        
            navBar.topAnchor.constraint(equalTo: view.topAnchor, constant: view.safeAreaInsets.top),
            navBar.leftAnchor.constraint(equalTo: view.leftAnchor),
            navBar.rightAnchor.constraint(equalTo: view.rightAnchor),
            
            favouriteImage.widthAnchor.constraint(equalToConstant: 22),
            favouriteImage.heightAnchor.constraint(equalToConstant: 22),
            favouriteImage.rightAnchor.constraint(equalTo: navBar.rightAnchor, constant: -25),
            favouriteImage.centerYAnchor.constraint(equalTo: navBar.centerYAnchor),
            
            scrollView.topAnchor.constraint(equalTo: navBar.bottomAnchor),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -view.safeAreaInsets.bottom),
            
            coverImage.topAnchor.constraint(equalTo: scrollView.topAnchor),
            coverImage.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            coverImage.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
            coverImage.widthAnchor.constraint(equalToConstant: view.frame.width),
            coverImage.heightAnchor.constraint(equalToConstant: ((PublicConstants.screenWidth)/16)*9),
            
            containerView.topAnchor.constraint(equalTo: coverImage.bottomAnchor),
            containerView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            containerView.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
            
            nameLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 25),
            nameLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -25),
            nameLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 15),
            nameLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -15),
            
            bottomLineView.topAnchor.constraint(equalTo: containerView.bottomAnchor),
            bottomLineView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            bottomLineView.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
            bottomLineView.heightAnchor.constraint(equalToConstant: 5),
            
            stackView.topAnchor.constraint(equalTo: bottomLineView.bottomAnchor, constant: 25),
            stackView.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 25),
            stackView.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: -25),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -80),
            
            emptyBackgroundView.topAnchor.constraint(equalTo: navBar.bottomAnchor),
            emptyBackgroundView.leftAnchor.constraint(equalTo: view.leftAnchor),
            emptyBackgroundView.rightAnchor.constraint(equalTo: view.rightAnchor),
            emptyBackgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -view.safeAreaInsets.bottom)
        
        ])
        
    }

    //MARK: - Setup
    
    private func setupGestures() {
        
        let edgePan = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(screenEdgeSwiped))
        edgePan.edges = .left
        view.addGestureRecognizer(edgePan)
        
        let swipeGes = UISwipeGestureRecognizer(target: self, action: #selector(screenSwiped))
        swipeGes.direction = .right
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(swipeGes)
        
    }
    
    private func setupViewModel() {
        
        viewModel?.itemSubject.sink(receiveValue: { bool in
            if bool {
                DispatchQueue.main.async { [weak self] in
                    self?.setupView()
                    self?.emptyBackgroundView.isHidden = true
                    self?.favouriteImage.isHidden = false
                }
            } else {
                DispatchQueue.main.async { [weak self] in
                    self?.emptyBackgroundView.isHidden = false
                    self?.coverImage.isHidden = true
                    self?.containerView.isHidden = true
                    self?.bottomLineView.isHidden = true
                }
            }
        }).store(in: &cancellableList)
        
        viewModel?.favouritedSubject.sink(receiveValue: { bool in
            DispatchQueue.main.async { [weak self] in
                if bool {
                    self?.favouriteImage.image = AppAsset.iconFavourite
                } else {
                    self?.favouriteImage.image = AppAsset.iconNotFavourite
                }
            }
        }).store(in: &cancellableList)
        
        viewModel?.getItem()
        viewModel?.checkIfFavourite()
        
    }

    func setupView() {
        
        guard let viewModel = viewModel else { return }
        
        coverImage.loadImageFromURL(urlString: viewModel.item?.coverImage ?? "")
        nameLabel.text = viewModel.item?.name
        
        let headerDetailView = CrosshairSingleDetailView()
        headerDetailView.configure(with: CrosshairDetailModel(orderNumber: 0, value: "Crosshair Detail".localized(), description: "Setting".localized()))
        headerDetailView.makeViewAsHeader()
        stackView.addArrangedSubview(headerDetailView)
        
        if let itemList = viewModel.item?.crosshairDetail {
            itemList.forEach {
                let detailView = CrosshairSingleDetailView()
                detailView.configure(with: $0)
                stackView.addArrangedSubview(detailView)
            }
        }
        
    }

    //MARK: - Configure

    private func configureNavBar() {
        navBar.configure(with: VHNavBarVM(
            navBarStyle: .withLogo,
            leftAction: { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }))
    }

    //MARK: - Actions

    @objc func onFavourite() {
        viewModel?.onFavourite()
    }
    
    @objc func screenEdgeSwiped(_ recognizer: UIScreenEdgePanGestureRecognizer) {
        if recognizer.state == .recognized {
            navigationController?.popViewController(animated: true)
        }
    }
    
    @objc func screenSwiped(_ recognizer: UISwipeGestureRecognizer) {
        if recognizer.state == .ended {
            navigationController?.popViewController(animated: true)
        }
    }
    
}
