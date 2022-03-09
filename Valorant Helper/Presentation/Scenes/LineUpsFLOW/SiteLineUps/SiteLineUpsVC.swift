import UIKit

class SiteLineUpsVC: UIViewController {
    
    //MARK: - Views

    let navBar = VHNavBar()
    
    let coverImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.masksToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = AppColor.darkWhite.color
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let headerLabel: UILabel = {
        let label = UILabel()
        label.font = AppFont.getBold(ofSize: 18)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero)
        table.backgroundColor = .clear
        table.separatorColor = .clear
        table.dataSource = self
        table.delegate = self
        table.bounces = true
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()

    //MARK: - Variables

    var viewModel: SiteLineUpsProtocol?

    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = AppColor.darkBlack.color
        tableView.register(SiteLineUpsCell.self, forCellReuseIdentifier: SiteLineUpsCell.reusableIdentifer)
        buildSubviews()
        setupGestures()
        setupView()
        configureNavBar()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        buildConstraints()
    }

    //MARK: - Build

    private func buildSubviews() {
        view.addSubview(navBar)
        view.addSubview(coverImage)
        view.addSubview(containerView)
        containerView.addSubview(headerLabel)
        view.addSubview(tableView)
    }

    private func buildConstraints() {
        
        NSLayoutConstraint.activate([
        
            navBar.topAnchor.constraint(equalTo: view.topAnchor, constant: view.safeAreaInsets.top),
            navBar.leftAnchor.constraint(equalTo: view.leftAnchor),
            navBar.rightAnchor.constraint(equalTo: view.rightAnchor),
            
            coverImage.topAnchor.constraint(equalTo: navBar.bottomAnchor),
            coverImage.leftAnchor.constraint(equalTo: view.leftAnchor),
            coverImage.rightAnchor.constraint(equalTo: view.rightAnchor),
            coverImage.heightAnchor.constraint(equalToConstant: 80),
            
            containerView.topAnchor.constraint(equalTo: coverImage.bottomAnchor),
            containerView.leftAnchor.constraint(equalTo: view.leftAnchor),
            containerView.rightAnchor.constraint(equalTo: view.rightAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 50),
            
            headerLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 25),
            headerLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -25),
            headerLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            
            tableView.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 15),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -view.safeAreaInsets.bottom)
        
        ])

    }

    //MARK: - Setup

    private func setupGestures() {
        
        let edgePan = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(screenEdgeSwiped))
        edgePan.edges = .left
        view.addGestureRecognizer(edgePan)
        
        let swipeGes = UISwipeGestureRecognizer(target: self, action: #selector(screenSwiped))
        swipeGes.direction = .right
        tableView.isUserInteractionEnabled = true
        tableView.addGestureRecognizer(swipeGes)
        
    }
    
    private func setupView() {
        
        guard let viewModel = viewModel else { return }
        
        coverImage.loadImageFromURL(urlString: viewModel.mapIcon ?? "")
        headerLabel.attributedText = viewModel.headerName
        
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

    //MARK: - DataSource, Delegate

extension SiteLineUpsVC: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.itemList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SiteLineUpsCell.reusableIdentifer) as! SiteLineUpsCell
        cell.configure(with: viewModel?.itemList?[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = LineUpDetailVC()
        vc.viewModel = LineUpDetailVMFactory.getLineUpDetailVM(from: viewModel, index: indexPath)
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
