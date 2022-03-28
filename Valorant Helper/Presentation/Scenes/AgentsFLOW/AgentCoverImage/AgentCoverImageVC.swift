import UIKit

class AgentCoverImageVC: UIViewController {
    
    //MARK: - Views

    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Preview".localized()
        label.font = AppFont.getMedium(ofSize: 18)
        label.textColor = AppColor.lightWhite.color
        label.textAlignment = .center
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var closeImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.layer.masksToBounds = true
        image.image = AppAsset.iconClose
        image.translatesAutoresizingMaskIntoConstraints = false
        image.isUserInteractionEnabled = true
        image.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onClose)))
        return image
    }()
    
    lazy var downloadImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.layer.masksToBounds = true
        image.image = AppAsset.iconDownload
        image.translatesAutoresizingMaskIntoConstraints = false
        image.isUserInteractionEnabled = true
        image.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onDownload)))
        return image
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = AppColor.mediumRed.color
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = AppColor.darkBlack.color
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let backgroundImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.layer.masksToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let agentImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.layer.masksToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
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
        collectionView.register(AgentCoverImageCell.self, forCellWithReuseIdentifier: AgentCoverImageCell.reusableIdentifer)
        return collectionView
    }()
    
    //MARK: - Variables
    
    var viewModel: AgentCoverImageVM?

    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = AppColor.darkBlack.color
        buildSubviews()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        buildConstraints()
    }

    //MARK: - Build

    private func buildSubviews() {
        view.addSubview(titleLabel)
        view.addSubview(closeImage)
        view.addSubview(downloadImage)
        view.addSubview(separatorView)
        view.addSubview(containerView)
        containerView.addSubview(backgroundImage)
        backgroundImage.addSubview(agentImage)
        view.addSubview(collectionView)
    }

    private func buildConstraints() {
        
        NSLayoutConstraint.activate([
        
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: view.safeAreaInsets.top+5),
            titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 70),
            titleLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -70),
            titleLabel.heightAnchor.constraint(equalToConstant: 40),
            
            closeImage.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -25),
            closeImage.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            closeImage.widthAnchor.constraint(equalToConstant: 30),
            closeImage.heightAnchor.constraint(equalToConstant: 30),
            
            downloadImage.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 25),
            downloadImage.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            downloadImage.widthAnchor.constraint(equalToConstant: 30),
            downloadImage.heightAnchor.constraint(equalToConstant: 30),
            
            separatorView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            separatorView.leftAnchor.constraint(equalTo: view.leftAnchor),
            separatorView.rightAnchor.constraint(equalTo: view.rightAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 2),
            
            containerView.topAnchor.constraint(equalTo: separatorView.bottomAnchor),
            containerView.leftAnchor.constraint(equalTo: view.leftAnchor),
            containerView.rightAnchor.constraint(equalTo: view.rightAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            backgroundImage.topAnchor.constraint(equalTo: containerView.topAnchor),
            backgroundImage.leftAnchor.constraint(equalTo: containerView.leftAnchor),
            backgroundImage.rightAnchor.constraint(equalTo: containerView.rightAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),

            agentImage.topAnchor.constraint(equalTo: backgroundImage.topAnchor),
            agentImage.leftAnchor.constraint(equalTo: backgroundImage.leftAnchor),
            agentImage.rightAnchor.constraint(equalTo: backgroundImage.rightAnchor),
            agentImage.bottomAnchor.constraint(equalTo: backgroundImage.bottomAnchor),
            
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 25),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -25),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -PublicConstants.bottomPadding),
            collectionView.heightAnchor.constraint(equalToConstant: 45)
        
        ])

    }

    //MARK: - Configure

    func configure(with vm: AgentCoverImageVM?) {
        backgroundImage.loadImageFromURL(urlString: vm?.backgroundImage ?? "")
        agentImage.loadImageFromURL(urlString: vm?.coverImage ?? "")
        viewModel = vm
    }
    
    private func saveCompleted() {
        let alert = UIAlertController(title: "Saved".localized(), message: "Image has been saved to your gallery.".localized(), preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK".localized(), style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }

    //MARK: - Actions

    @objc func onClose() {
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut) { [weak self] in
            self?.closeImage.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        } completion: { [weak self] _ in
            self?.dismiss(animated: true)
        }
    }
    
    @objc func onDownload() {
        UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseOut) { [weak self] in
            self?.downloadImage.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        } completion: { _ in
            UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseIn) { [weak self] in
                self?.downloadImage.transform = CGAffineTransform.identity
            } completion: { [weak self] _ in
                guard let image = self?.containerView.asImage() else { return }
                UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
                self?.saveCompleted()
            }
        }
    }
    
}

extension AgentCoverImageVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel?.itemList.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AgentCoverImageCell.reusableIdentifer, for: indexPath) as! AgentCoverImageCell
        cell.configure(with: viewModel?.itemList[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 45, height: 45)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel?.changeItemList(on: indexPath, completion: { bool in
            if bool {
                DispatchQueue.main.async { [weak self] in
                    self?.containerView.backgroundColor = self?.viewModel?.itemList[indexPath.row].color.color
                    self?.collectionView.reloadData()
                }
            }
        })
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        15
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        15
    }
    
}
