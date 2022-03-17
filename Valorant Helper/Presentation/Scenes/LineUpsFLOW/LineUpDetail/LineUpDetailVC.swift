import UIKit
import Combine


class LineUpDetailVC: UIViewController {
    
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
    
    let mapImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.masksToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let titleView: UIView = {
        let view = UIView()
        view.backgroundColor = AppColor.darkWhite.color
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColor.extraBlack.color
        label.font = AppFont.getBold(ofSize: 20)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let descriptionTagLabel: UILabel = {
        let label = UILabel()
        label.text = "//DESCRIPTION".localized()
        label.textColor = AppColor.darkWhite.color
        label.font = AppFont.getLight(ofSize: 10)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColor.lightWhite.color
        label.font = AppFont.getRegular(ofSize: 14)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let requirementsTagLabel: UILabel = {
        let label = UILabel()
        label.text = "//REQUIREMENTS".localized()
        label.textColor = AppColor.darkWhite.color
        label.font = AppFont.getLight(ofSize: 10)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let requirementsLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColor.lightWhite.color
        label.font = AppFont.getRegular(ofSize: 14)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let emptyBackgroundView = EmptyBackgroundView()

    //MARK: - Variables

    var viewModel: LineUpDetailVMProtocol?
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
        scrollView.addSubview(mapImage)
        scrollView.addSubview(titleView)
        titleView.addSubview(titleLabel)
        scrollView.addSubview(descriptionTagLabel)
        scrollView.addSubview(descriptionLabel)
        scrollView.addSubview(requirementsTagLabel)
        scrollView.addSubview(requirementsLabel)
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
            
            mapImage.topAnchor.constraint(equalTo: scrollView.topAnchor),
            mapImage.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            mapImage.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
            mapImage.widthAnchor.constraint(equalToConstant: view.frame.width),
            mapImage.heightAnchor.constraint(greaterThanOrEqualToConstant: 80),
            mapImage.heightAnchor.constraint(equalToConstant: (PublicConstants.screenWidth)/5),
            
            titleView.topAnchor.constraint(equalTo: mapImage.bottomAnchor),
            titleView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            titleView.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: titleView.topAnchor, constant: 10),
            titleLabel.leftAnchor.constraint(equalTo: titleView.leftAnchor, constant: 25),
            titleLabel.rightAnchor.constraint(equalTo: titleView.rightAnchor, constant: -25),
            titleLabel.bottomAnchor.constraint(equalTo: titleView.bottomAnchor, constant: -10),
            
            descriptionTagLabel.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: 15),
            descriptionTagLabel.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 25),
            descriptionTagLabel.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: -25),
            
            descriptionLabel.topAnchor.constraint(equalTo: descriptionTagLabel.bottomAnchor, constant: 5),
            descriptionLabel.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 25),
            descriptionLabel.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: -25),
            
            requirementsTagLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 15),
            requirementsTagLabel.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 25),
            requirementsTagLabel.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: -25),
            
            requirementsLabel.topAnchor.constraint(equalTo: requirementsTagLabel.bottomAnchor, constant: 5),
            requirementsLabel.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 25),
            requirementsLabel.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: -25),
            
            stackView.topAnchor.constraint(equalTo: requirementsLabel.bottomAnchor, constant: 15),
            stackView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            stackView.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -60),
            
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
                }
            } else {
                DispatchQueue.main.async { [weak self] in
                    self?.emptyBackgroundView.isHidden = false
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
        
    }
    
    func setupView() {
        
        guard let viewModel = viewModel else { return }
        
        mapImage.loadImageFromURL(urlString: viewModel.mapIcon ?? "")
        titleLabel.text = viewModel.item?.name
        descriptionLabel.text = viewModel.item?.description
        requirementsLabel.text = viewModel.getRequiremets
        
        descriptionTagLabel.isHidden = false
        requirementsTagLabel.isHidden = false
        emptyBackgroundView.isHidden = true
        favouriteImage.isHidden = false
        titleView.isHidden = false
        
        viewModel.item?.steps?.forEach {
            let step = SingleStepView()
            step.configure(with: $0)
            stackView.addArrangedSubview(step)
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

