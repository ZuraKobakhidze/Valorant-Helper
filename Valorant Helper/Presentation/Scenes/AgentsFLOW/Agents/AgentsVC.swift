import UIKit
import Combine

class AgentsVC: UIViewController {
    
    //MARK: - Views
    
    let headerLabel: UILabel = {
        let label = UILabel()
        label.text = "AGENTS".localized()
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
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: (view.frame.width - 50 - 10)/2, height: (view.frame.width - 50 - 10)/2)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 25, bottom: 0, right: 25)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(AgentsHeaderViewCell.self, forCellWithReuseIdentifier: AgentsHeaderViewCell.reusableIdentifer)
        return collectionView
    }()
    
    let emptyBackgroundView = EmptyBackgroundView()

    //MARK: - Variables

    let viewModel: AgentsVMProtocol = AgentsVM()
    var cancellableList: Set<AnyCancellable> = []

    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = AppColor.darkBlack.color
        collectionView.register(AgentsCell.self, forCellWithReuseIdentifier: AgentsCell.reusableIdentifer)
        collectionView.register(AgentsFooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: AgentsFooterView.reusableIdentifer)
        buildSubviews()
        setupHeaderView()
        setupViewModel()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        buildConstraints()
    }

    //MARK: - Build

    private func buildSubviews() {
        view.addSubview(headerLabel)
        view.addSubview(reloadImage)
        view.addSubview(headerView)
        view.addSubview(collectionView)
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
            
            collectionView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 15),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -view.safeAreaInsets.bottom),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            
            emptyBackgroundView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 15),
            emptyBackgroundView.rightAnchor.constraint(equalTo: view.rightAnchor),
            emptyBackgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -view.safeAreaInsets.bottom),
            emptyBackgroundView.leftAnchor.constraint(equalTo: view.leftAnchor),
        
        ])
        
    }

    //MARK: - Setup

    private func setupHeaderView() {
        
        headerView.viewModel.itemSubject.sink { [weak self] agentDataType in
            self?.viewModel.filterItemList(by: agentDataType)
        }.store(in: &cancellableList)
        
    }
    
    private func setupViewModel() {
        
        viewModel.itemSubject.sink {bool in
            
            if bool {
                DispatchQueue.main.async { [weak self] in
                    self?.headerView.isUserInteractionEnabled = true
                    self?.collectionView.reloadData()
                    self?.collectionView.setContentOffset(CGPoint(x:0,y:0), animated: true)
                    self?.emptyBackgroundView.isHidden = true
                }
            } else {
                DispatchQueue.main.async { [weak self] in
                    self?.headerView.isUserInteractionEnabled = true
                    self?.collectionView.reloadData()
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

    //MARK: - DataSource & Delegate

extension AgentsVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.itemList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AgentsCell.reusableIdentifer, for: indexPath) as! AgentsCell
        cell.configure(with: viewModel.itemList?[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = AgentDetailVC()
        vc.viewModel = AgentDetailVM(name: viewModel.itemList?[indexPath.row].pathName ?? "")
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        10
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        cell.alpha = 0
        cell.transform = CGAffineTransform(scaleX: 0.4, y: 0.4)
        UIView.animate(withDuration: 0.4, delay: 0, options: [.curveEaseOut]) {
            cell.alpha = 1
            cell.transform = CGAffineTransform.identity
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionView.elementKindSectionFooter {
            
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: AgentsFooterView.reusableIdentifer, for: indexPath) as! AgentsFooterView
            footer.configure()
            return footer
            
        } else {
            return UICollectionReusableView()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        CGSize(width: view.frame.width-50, height: 60)
    }
    
}
