import UIKit
import Combine

class CrosshairsVC: UIViewController {
    
    //MARK: - Views
    
    let headerLabel: UILabel = {
        let label = UILabel()
        label.text = "CROSSHAIRS".localized()
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
        table.bounces = true
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()

    //MARK: - Variables

    let viewModel: CrosshairsVMProtocol = CrosshairsVM()
    var cancellableList: Set<AnyCancellable> = []

    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = AppColor.darkBlack.color
        tableView.register(CrosshairsCell.self, forCellReuseIdentifier: CrosshairsCell.reusableIdentifer)
        buildSubviews()
        setupViewModel()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        buildConstraints()
    }

    //MARK: - Build

    private func buildSubviews() {
        view.addSubview(headerLabel)
        view.addSubview(tableView)
    }

    private func buildConstraints() {

        NSLayoutConstraint.activate([
        
            headerLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: view.safeAreaInsets.top+25),
            headerLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 25),
            headerLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -25),
            
            tableView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 15),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -view.safeAreaInsets.bottom)
        
        ])
        
    }

    //MARK: - Setup

    private func setupViewModel() {
        
        viewModel.itemSubject.sink { _ in
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }.store(in: &cancellableList)
        viewModel.getItems()
        
    }

    //MARK: - Configure

    // Your Configure Methods Here

    //MARK: - Actions

    // Your Actions Here
    
}

    //MARK: - DataSource, Delegate

extension CrosshairsVC: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.itemList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CrosshairsCell.reusableIdentifer) as! CrosshairsCell
        cell.configure(with: viewModel.itemList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = CrosshairDetailVC()
        vc.viewModel = CrosshairDetailVM(item: viewModel.itemList[indexPath.row])
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
