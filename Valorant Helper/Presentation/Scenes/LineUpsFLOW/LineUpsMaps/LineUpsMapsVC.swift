import UIKit

class LineUpsMapVC: UIViewController {
    
    //MARK: - Views

    let navBar = VHNavBar()
    
    let headerLabel: UILabel = {
        let label = UILabel()
        label.text = "MAPS".localized()
        label.textColor = AppColor.lightWhite.color
        label.font = AppFont.getBold(ofSize: 20)
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
        table.bounces = false
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()

    //MARK: - Variables

    var viewModel: LineUpsMapVMProtocol?

    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = AppColor.darkBlack.color
        buildSubviews()
        setupGestures()
        configureNavBar()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        buildConstraints()
    }

    //MARK: - Build

    private func buildSubviews() {
        view.addSubview(navBar)
        view.addSubview(headerLabel)
        view.addSubview(tableView)
    }

    private func buildConstraints() {

        NSLayoutConstraint.activate([
        
            navBar.topAnchor.constraint(equalTo: view.topAnchor, constant: view.safeAreaInsets.top),
            navBar.leftAnchor.constraint(equalTo: view.leftAnchor),
            navBar.rightAnchor.constraint(equalTo: view.rightAnchor),
            
            headerLabel.topAnchor.constraint(equalTo: navBar.bottomAnchor, constant: 15),
            headerLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 25),
            headerLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -25),
            
            tableView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 15),
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

    //MARK: - Configure

    private func configureNavBar() {
        navBar.configure(with: VHNavBarVM(
            navBarStyle: .withAgentImage(agentImage: viewModel?.agentImage ?? ""),
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

extension LineUpsMapVC: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
}
