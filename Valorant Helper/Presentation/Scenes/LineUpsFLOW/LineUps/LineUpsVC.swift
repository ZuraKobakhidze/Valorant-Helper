import UIKit
import Combine

class LineUpsVC: UIViewController {
    
    //MARK: - Views
    
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
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    let footerView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 60))
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

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
        view.addSubview(headerView)
        view.addSubview(tableView)
    }

    private func buildConstraints() {

        NSLayoutConstraint.activate([
        
            headerView.topAnchor.constraint(equalTo: view.topAnchor, constant: view.safeAreaInsets.top+25),
            headerView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 25),
            headerView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -25),
            headerView.heightAnchor.constraint(equalToConstant: 35),
            
            tableView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 15),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -view.safeAreaInsets.bottom)
        
        ])
        
    }

    //MARK: - Setup

    private func setupHeaderView() {
        
        headerView.viewModel.itemSubject.sink { [weak self] agentDataType in
            self?.viewModel.filterItemList(by: agentDataType)
        }.store(in: &cancellableList)
        
    }
    
    private func setupViewModel() {
        
        viewModel.itemSubject.sink { _ in
            DispatchQueue.main.async { [weak self] in
                self?.headerView.isUserInteractionEnabled = true
                self?.tableView.reloadData()
            }
        }.store(in: &cancellableList)
        viewModel.getAllItems()
        
    }

    //MARK: - Configure

    // Your Configure Methods Here

    //MARK: - Actions

    // Your Actions Here
    
}

    //MARK: - DataSource, Delegate

extension LineUpsVC: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.itemList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LineUpsCell.reusableIdentifer) as! LineUpsCell
        cell.configure(with: viewModel.itemList?[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = LineUpsMapVC()
        vc.viewModel = LineUpsMapVM(agentPath: viewModel.itemList?[indexPath.row]?.pathName ?? "", agentImage: viewModel.itemList?[indexPath.row]?.displayIcon ?? "")
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
