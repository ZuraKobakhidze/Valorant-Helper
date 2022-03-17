import UIKit

class EmptyBackgroundView: UIView {
    
    //MARK: - Views

    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.borderColor = AppColor.mediumRed.color.cgColor
        view.layer.borderWidth = 2
        view.layer.cornerRadius = 65
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 7
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let imageView: UIImageView = {
        let image = UIImageView()
        image.image = AppAsset.iconEmpty
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColor.mediumRed.color
        label.font = AppFont.getBold(ofSize: 12)
        label.numberOfLines = 2
        label.textAlignment = .center
        label.text = "NO DATA".localized()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    //MARK: - Variables

    // Your Variables Here

    //MARK: - Init

    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        isHidden = true
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
        addSubview(containerView)
        containerView.addSubview(stackView)
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(titleLabel)
    }

    private func buildConstraints() {

        NSLayoutConstraint.activate([
        
            containerView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            containerView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 130),
            containerView.heightAnchor.constraint(equalToConstant: 130),
            
            stackView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            stackView.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 20),
            stackView.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -20),
            
            imageView.widthAnchor.constraint(equalToConstant: 38),
            imageView.heightAnchor.constraint(equalToConstant: 25),
        
        ])
        
    }

    //MARK: - Setup

    // Your Setup Methods Here

    //MARK: - Actions

    // Your Actions Here
    
}
