import UIKit
import Combine

class LineUpsVC: UIViewController {
    
    //MARK: - Views
    
    let headerLabel: UILabel = {
        let label = UILabel()
        label.text = "LINE-UPS".localized()
        label.textColor = AppColor.lightWhite.color
        label.font = AppFont.getBold(ofSize: 20)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var reloadImage: UIImageView = {
        let image = UIImageView()
        image.image = AppAsset.iconReload
        image.contentMode = .scaleAspectFit
        image.layer.masksToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        image.isUserInteractionEnabled = true
        image.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onReload)))
        return image
    }()
    
    let headerView: AgentsHeaderView = {
        let headerView = AgentsHeaderView()
        headerView.isUserInteractionEnabled = false
        return headerView
    }()

    lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero)
        table.backgroundColor = .clear
        table.separatorColor = .clear
        table.dataSource = self
        table.delegate = self
        table.bounces = true
        table.showsVerticalScrollIndicator = false
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    let footerView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 60))
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let emptyBackgroundView = EmptyBackgroundView()

    //MARK: - Variables

    var viewModel: LineUpsVMProtocol = LineUpsVM()
    var cancellableList: Set<AnyCancellable> = []

    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = AppColor.darkBlack.color
        tableView.register(LineUpsCell.self, forCellReuseIdentifier: LineUpsCell.reusableIdentifer)
        tableView.tableFooterView = footerView
        buildSubviews()
        setupHeaderView()
        setupViewModel()
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
        view.addSubview(headerLabel)
        view.addSubview(reloadImage)
        view.addSubview(headerView)
        view.addSubview(tableView)
        view.addSubview(emptyBackgroundView)
    }

    private func buildConstraints() {

        NSLayoutConstraint.activate([
        
            headerLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: view.safeAreaInsets.top+25),
            headerLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 25),
            headerLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -25),
            
            reloadImage.widthAnchor.constraint(equalToConstant: 15),
            reloadImage.heightAnchor.constraint(equalToConstant: 15),
            reloadImage.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -25),
            reloadImage.centerYAnchor.constraint(equalTo: headerLabel.centerYAnchor),
            
            headerView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 15),
            headerView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 25),
            headerView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -25),
            headerView.heightAnchor.constraint(equalToConstant: 35),
            
            tableView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 15),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -view.safeAreaInsets.bottom),
            
            emptyBackgroundView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 15),
            emptyBackgroundView.leftAnchor.constraint(equalTo: view.leftAnchor),
            emptyBackgroundView.rightAnchor.constraint(equalTo: view.rightAnchor),
            emptyBackgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -view.safeAreaInsets.bottom)
        
        ])
        
    }

    //MARK: - Setup

    private func setupHeaderView() {
        
        headerView.viewModel.itemSubject.sink { [weak self] agentDataType in
            self?.viewModel.filterItemList(by: agentDataType)
        }.store(in: &cancellableList)
        
    }
    
    private func setupViewModel() {
        
        viewModel.itemSubject.sink { bool in
            
            if bool {
                DispatchQueue.main.async { [weak self] in
                    self?.headerView.isUserInteractionEnabled = true
                    self?.tableView.reloadData()
                    self?.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
                    self?.emptyBackgroundView.isHidden = true
                }
            } else {
                DispatchQueue.main.async { [weak self] in
                    self?.headerView.isUserInteractionEnabled = true
                    self?.tableView.reloadData()
                    self?.emptyBackgroundView.isHidden = false
                }
            }
            
        }.store(in: &cancellableList)
        viewModel.getAllItems()
        
    }

    //MARK: - Configure

    // Your Configure Methods Here

    //MARK: - Actions

    @objc func onReload() {
        
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn) { [unowned self] in
            self.reloadImage.transform = self.reloadImage.transform.rotated(by: .pi)
            self.reloadImage.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        } completion: { [unowned self] _ in
            UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseOut) { [unowned self] in
                self.reloadImage.transform = self.reloadImage.transform.rotated(by: .pi)
                self.reloadImage.transform = CGAffineTransform.identity
            } completion: { [unowned self] _ in
                self.viewModel.refreshItemList(by: self.headerView.viewModel.agentType)
            }
        }

    }
    
}

    //MARK: - DataSource, Delegate

extension LineUpsVC: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.itemList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LineUpsCell.reusableIdentifer, for: indexPath) as! LineUpsCell
        cell.configure(with: viewModel.itemList?[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = LineUpsMapVC()
        vc.viewModel = LineUpsMapVM(agentPath: viewModel.itemList?[indexPath.row]?.pathName ?? "", agentImage: viewModel.itemList?[indexPath.row]?.displayIcon ?? "")
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        cell.alpha = 0
        cell.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        
        UIView.animate(withDuration: 0.4, delay: 0.1, options: .curveEaseOut) {
            cell.alpha = 1
            cell.transform = CGAffineTransform.identity
        }
        
    }
    
}
