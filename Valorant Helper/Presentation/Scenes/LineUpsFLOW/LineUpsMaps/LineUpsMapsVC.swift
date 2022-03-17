import UIKit
import Combine

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
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero)
        table.backgroundColor = .clear
        table.separatorColor = .clear
        table.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 60))
        table.dataSource = self
        table.delegate = self
        table.bounces = true
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    let emptyBackgroundView = EmptyBackgroundView()

    //MARK: - Variables

    var viewModel: LineUpsMapVMProtocol?
    var cancellableList: Set<AnyCancellable> = []

    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = AppColor.darkBlack.color
        tableView.register(LineUpsMapsCell.self, forCellReuseIdentifier: LineUpsMapsCell.reusableIdentifer)
        tableView.register(LineUpsMapsSectionCell.self, forCellReuseIdentifier: LineUpsMapsSectionCell.reusableIdentifer)
        buildSubviews()
        setupGestures()
        setupViewModel()
        configureNavBar()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        buildConstraints()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.layoutFooter()
    }

    //MARK: - Build

    private func buildSubviews() {
        view.addSubview(navBar)
        view.addSubview(headerLabel)
        view.addSubview(tableView)
        view.addSubview(emptyBackgroundView)
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
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -view.safeAreaInsets.bottom),
            
            emptyBackgroundView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 15),
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
                    self?.tableView.reloadData()
                    self?.emptyBackgroundView.isHidden = true
                    self?.headerLabel.isHidden = false
                }
            } else {
                DispatchQueue.main.async { [weak self] in
                    self?.tableView.reloadData()
                    self?.emptyBackgroundView.isHidden = false
                    self?.headerLabel.isHidden = true
                }
            }
        }).store(in: &cancellableList)
        
        viewModel?.sectionReloadSubject.sink(receiveValue: { section in
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadSections(IndexSet(integer: section), with: .none)
            }
        }).store(in: &cancellableList)
        
        viewModel?.getItemList()
        
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel?.itemList.count ?? 0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let viewModel = viewModel else { return 0 }
        
        if viewModel.itemList[section].isCollapsed {
            return 1
        } else {
            return (viewModel.itemList[section].item?.site?.count ?? 0) + 1
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: LineUpsMapsSectionCell.reusableIdentifer, for: indexPath) as! LineUpsMapsSectionCell
            cell.configure(with: viewModel?.itemList[indexPath.section])
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: LineUpsMapsCell.reusableIdentifer, for: indexPath) as! LineUpsMapsCell
            cell.configure(with: viewModel?.itemList[indexPath.section].item?.site?[indexPath.row - 1])
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            viewModel?.collapseItems(on: indexPath.section)
        } else {
            let vc = SiteLineUpsVC()
            vc.viewModel = SiteLineUpsVMFactory.getSiteLineUpsVM(from: viewModel, index: indexPath)
            navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 15))
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 { return }
        
        cell.alpha = 0
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn) {
            cell.alpha = 1
        }

    }
    
}
