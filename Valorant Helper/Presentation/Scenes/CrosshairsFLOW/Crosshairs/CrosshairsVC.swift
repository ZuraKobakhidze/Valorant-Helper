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
    
    let emptyBackgroundView = EmptyBackgroundView()

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
        view.addSubview(emptyBackgroundView)
    }

    private func buildConstraints() {

        NSLayoutConstraint.activate([
        
            headerLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: view.safeAreaInsets.top+25),
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

    private func setupViewModel() {
        
        viewModel.itemSubject.sink { bool in
            if bool {
                DispatchQueue.main.async { [weak self] in
                    self?.tableView.reloadData()
                    self?.emptyBackgroundView.isHidden = true
                }
            } else {
                DispatchQueue.main.async { [weak self] in
                    self?.tableView.reloadData()
                    self?.emptyBackgroundView.isHidden = false
                }
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
        let cell = tableView.dequeueReusableCell(withIdentifier: CrosshairsCell.reusableIdentifer, for: indexPath) as! CrosshairsCell
        cell.configure(with: viewModel.itemList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = CrosshairDetailVC()
        vc.viewModel = CrosshairDetailVM(id: viewModel.itemList[indexPath.row].id)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        cell.alpha = 0
        cell.transform = CGAffineTransform(scaleX: 0.4, y: 0.4)
        
        UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseOut) {
            cell.alpha = 1
            cell.transform = CGAffineTransform.identity
        }
        
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        let currentOffset = scrollView.contentOffset.y
        
        if currentOffset <= -30.0 {
            viewModel.getItems()
        }
        
    }
    
}
