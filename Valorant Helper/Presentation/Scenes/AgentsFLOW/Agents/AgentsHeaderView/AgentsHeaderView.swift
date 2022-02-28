import UIKit
import Combine

class AgentsHeaderView: UIView {
    
    //MARK: - Views

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
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

    //MARK: - Variables

    let viewModel: AgentsHeaderViewVMProtocol = AgentsHeaderViewVM()
    var cancellableList: Set<AnyCancellable> = []

    //MARK: - Init

    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        setupDataSource()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }

    //MARK: - Functions

    override func layoutSubviews() {
        super.layoutSubviews()
        
        buildSubviews()
        buildConstraints()
    }

    //MARK: - Build

    private func buildSubviews() {
        addSubview(collectionView)
    }

    private func buildConstraints() {

        NSLayoutConstraint.activate([
        
            collectionView.topAnchor.constraint(equalTo: self.topAnchor),
            collectionView.rightAnchor.constraint(equalTo: self.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            collectionView.leftAnchor.constraint(equalTo: self.leftAnchor)
        
        ])
        
    }

    //MARK: - Setup

    private func setupDataSource() {
        
        viewModel.itemSubject.sink { _ in
            DispatchQueue.main.async { [weak self] in
                self?.collectionView.reloadData()   
            }
        }.store(in: &cancellableList)
        
    }

    //MARK: - Actions

    // Your Actions Here
    
}

    //MARK: - DataSource & Delegate

extension AgentsHeaderView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.itemList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AgentsHeaderViewCell.reusableIdentifer, for: indexPath) as! AgentsHeaderViewCell
        cell.configure(with: viewModel.itemList[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: viewModel.widthForLabel(to: indexPath), height: 35)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.changeItemListIsOn(on: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        20
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
}
