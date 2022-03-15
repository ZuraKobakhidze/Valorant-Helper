import UIKit
import Combine

class FavouritesVC: UIViewController {
    
    //MARK: - Views
    
    let headerLabel: UILabel = {
        let label = UILabel()
        label.text = "FAVOURITES".localized()
        label.textColor = AppColor.lightWhite.color
        label.font = AppFont.getBold(ofSize: 20)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let dataSelectorView = FavouritesDataSelectorView()

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

    let viewModel = FavouritesVM()
    var cancellableList: Set<AnyCancellable> = []

    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = AppColor.darkBlack.color
        tableView.register(CrosshairsCell.self, forCellReuseIdentifier: CrosshairsCell.reusableIdentifer)
        tableView.register(FavouritesLineUpCell.self, forCellReuseIdentifier: FavouritesLineUpCell.reusableIdentifer)
        buildSubviews()
        setupDataSelection()
        setupViewModel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        viewModel.fetchData()
        viewModel.changeData(to: dataSelectorView.currentIndex)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        buildConstraints()
    }

    //MARK: - Build

    private func buildSubviews() {
        view.addSubview(headerLabel)
        view.addSubview(dataSelectorView)
        view.addSubview(tableView)
    }

    private func buildConstraints() {

        NSLayoutConstraint.activate([
        
            headerLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: view.safeAreaInsets.top+25),
            headerLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 25),
            headerLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -25),
            
            dataSelectorView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 15),
            dataSelectorView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 25),
            dataSelectorView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -25),
            
            tableView.topAnchor.constraint(equalTo: dataSelectorView.bottomAnchor, constant: 15),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -view.safeAreaInsets.bottom)
        
        ])
        
    }

    //MARK: - Setup

    private func setupDataSelection() {
        
        dataSelectorView.$currentIndex.sink { [weak self] index in
            self?.viewModel.changeData(to: index)
        }.store(in: &cancellableList)
        
    }
    
    private func setupViewModel() {
        
        viewModel.itemSubject.sink { _ in
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }.store(in: &cancellableList)
        
    }

    //MARK: - Configure

    // Your Configure Methods Here

    //MARK: - Actions

    // Your Actions Here
    
}

    //MARK: - DataSource, Delegate

extension FavouritesVC: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.itemList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let item = viewModel.itemList[indexPath.row] as? LineUpCD {
            let cell = tableView.dequeueReusableCell(withIdentifier: FavouritesLineUpCell.reusableIdentifer, for: indexPath) as! FavouritesLineUpCell
            cell.configure(with: item)
            return cell
        }
        
        if let item = viewModel.itemList[indexPath.row] as? CrosshairCD {
            let cell = tableView.dequeueReusableCell(withIdentifier: CrosshairsCell.reusableIdentifer, for: indexPath) as! CrosshairsCell
            cell.configure(with: item)
            return cell
        }
 
        return UITableViewCell()
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let item = viewModel.itemList[indexPath.row] as? LineUpCD {
            let vc = LineUpDetailVC()
            vc.viewModel = LineUpDetailVMFactory.getLineUpDetailVM(from: item)
            navigationController?.pushViewController(vc, animated: true)
        }
        
        if let item = viewModel.itemList[indexPath.row] as? CrosshairCD {
            let vc = CrosshairDetailVC()
            vc.viewModel = CrosshairDetailVM(id: item.id)
            navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if let _ = viewModel.itemList[indexPath.row] as? LineUpCD {
            cell.alpha = 0
            cell.transform = CGAffineTransform(translationX: PublicConstants.screenWidth, y: 0)
            
            UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseOut) {
                cell.alpha = 1
                cell.transform = CGAffineTransform.identity
            }
            return
        }
        
        if let _ = viewModel.itemList[indexPath.row] as? CrosshairCD {
            cell.alpha = 0
            cell.transform = CGAffineTransform(scaleX: 0.4, y: 0.4)
            
            UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseOut) {
                cell.alpha = 1
                cell.transform = CGAffineTransform.identity
            }
            return
        }
        
    }
    
}
