import UIKit
import Combine

class AgentDetailVC: UIViewController {
    
    //MARK: - Views

    let navBar = VHNavBar()
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = AppColor.darkBlack.color
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.alpha = 0
        return scrollView
    }()
    
    let backgroundImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.layer.masksToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let coverImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.layer.masksToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColor.lightWhite.color
        label.font = AppFont.getVALORANT(ofSize: 24)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let roleTagLabel: UILabel = {
        let label = UILabel()
        label.text = "//ROLE".localized()
        label.textColor = AppColor.darkWhite.color
        label.font = AppFont.getLight(ofSize: 10)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let roleLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColor.lightWhite.color
        label.font = AppFont.getMedium(ofSize: 18)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let roleImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.layer.masksToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let roleDescriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColor.lightWhite.color
        label.font = AppFont.getRegular(ofSize: 14)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let biographyTagLabel: UILabel = {
        let label = UILabel()
        label.text = "//BIOGRAPHY".localized()
        label.textColor = AppColor.darkWhite.color
        label.font = AppFont.getLight(ofSize: 10)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let biographyDescriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColor.lightWhite.color
        label.font = AppFont.getRegular(ofSize: 14)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let specialAbilitiesLabel: UILabel = {
        let label = UILabel()
        label.text = "SPECIAL ABILITIES".localized()
        label.textColor = AppColor.lightWhite.color
        label.font = AppFont.getSemiBold(ofSize: 18)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let emptyBackgroundView = EmptyBackgroundView()

    //MARK: - Variables

    var viewModel: AgentDetailVMProtocol?
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
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        buildConstraints()
    }

    //MARK: - Build

    private func buildSubviews() {
        view.addSubview(navBar)
        view.addSubview(scrollView)
        scrollView.addSubview(backgroundImage)
        scrollView.addSubview(coverImage)
        scrollView.addSubview(nameLabel)
        scrollView.addSubview(roleTagLabel)
        scrollView.addSubview(roleLabel)
        scrollView.addSubview(roleImage)
        scrollView.addSubview(roleDescriptionLabel)
        scrollView.addSubview(biographyTagLabel)
        scrollView.addSubview(biographyDescriptionLabel)
        scrollView.addSubview(specialAbilitiesLabel)
        scrollView.addSubview(stackView)
        view.addSubview(emptyBackgroundView)
    }

    private func buildConstraints() {

        NSLayoutConstraint.activate([
        
            navBar.topAnchor.constraint(equalTo: view.topAnchor, constant: view.safeAreaInsets.top),
            navBar.leftAnchor.constraint(equalTo: view.leftAnchor),
            navBar.rightAnchor.constraint(equalTo: view.rightAnchor),
            
            scrollView.topAnchor.constraint(equalTo: navBar.bottomAnchor),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -view.safeAreaInsets.bottom),
            
            backgroundImage.topAnchor.constraint(equalTo: scrollView.topAnchor),
            backgroundImage.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            backgroundImage.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
            backgroundImage.widthAnchor.constraint(equalToConstant: view.frame.width),
            backgroundImage.heightAnchor.constraint(equalToConstant: 300),
            
            coverImage.topAnchor.constraint(equalTo: scrollView.topAnchor),
            coverImage.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            coverImage.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
            coverImage.widthAnchor.constraint(equalToConstant: view.frame.width),
            coverImage.heightAnchor.constraint(equalToConstant: 300),
            
            nameLabel.topAnchor.constraint(equalTo: coverImage.bottomAnchor, constant: 20),
            nameLabel.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 25),
            nameLabel.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: -25),
            
            roleTagLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            roleTagLabel.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 25),
            roleTagLabel.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: -25),
        
            roleLabel.topAnchor.constraint(equalTo: roleTagLabel.bottomAnchor, constant: 5),
            roleLabel.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 25),
            
            roleImage.leftAnchor.constraint(equalTo: roleLabel.rightAnchor, constant: 10),
            roleImage.centerYAnchor.constraint(equalTo: roleLabel.centerYAnchor),
            roleImage.widthAnchor.constraint(equalToConstant: 15),
            roleImage.heightAnchor.constraint(equalToConstant: 15),
            
            roleDescriptionLabel.topAnchor.constraint(equalTo: roleLabel.bottomAnchor, constant: 5),
            roleDescriptionLabel.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 25),
            roleDescriptionLabel.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: -25),
            
            biographyTagLabel.topAnchor.constraint(equalTo: roleDescriptionLabel.bottomAnchor, constant: 10),
            biographyTagLabel.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 25),
            biographyTagLabel.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: -25),
            
            biographyDescriptionLabel.topAnchor.constraint(equalTo: biographyTagLabel.bottomAnchor, constant: 5),
            biographyDescriptionLabel.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 25),
            biographyDescriptionLabel.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: -25),
            
            specialAbilitiesLabel.topAnchor.constraint(equalTo: biographyDescriptionLabel.bottomAnchor, constant: 20),
            specialAbilitiesLabel.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 25),
            specialAbilitiesLabel.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: -25),
            
            stackView.topAnchor.constraint(equalTo: specialAbilitiesLabel.bottomAnchor, constant: 10),
            stackView.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 25),
            stackView.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: -25),
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
                    self?.emptyBackgroundView.isHidden = true
                }
            } else {
                DispatchQueue.main.async { [weak self] in
                    self?.emptyBackgroundView.isHidden = false
                }
            }
        }).store(in: &cancellableList)
        viewModel?.getItem()
    }
    
    func setupView() {
        
        guard let item = viewModel?.item else { return }
        
        backgroundImage.loadImageFromURL(urlString: item.background ?? "")
        coverImage.loadImageFromURL(urlString: item.fullPortrait ?? "")
        nameLabel.text = item.displayName
        roleLabel.text = item.role?.displayName
        roleImage.loadImageFromURL(urlString: item.role?.displayIcon ?? "")
        roleDescriptionLabel.text = item.role?.description
        biographyDescriptionLabel.text = item.description
        
        roleTagLabel.isHidden = false
        biographyTagLabel.isHidden = false
        specialAbilitiesLabel.isHidden = false
        
        if let abilities = item.abilities {
            for ability in abilities {
                let abilityView = AgentAbilityView()
                abilityView.configure(with: AgentAbilityViewVM(item: ability))
                stackView.addArrangedSubview(abilityView)
            }
        }
        
        UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseIn) { [weak self] in
            self?.scrollView.alpha = 1
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
