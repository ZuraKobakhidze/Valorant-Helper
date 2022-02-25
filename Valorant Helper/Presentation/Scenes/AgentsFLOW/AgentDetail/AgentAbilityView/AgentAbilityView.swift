import UIKit

class AgentAbilityView: UIView {
    
    //MARK: - Views

    let abilityImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.layer.masksToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let abilityNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColor.lightWhite.color
        label.font = AppFont.getMedium(ofSize: 16)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let abilityDescriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColor.mediumWhite.color
        label.font = AppFont.getLight(ofSize: 14)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    //MARK: - Variables

    // Your Variables Here

    //MARK: - Init

    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
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
        addSubview(abilityImage)
        addSubview(abilityNameLabel)
        addSubview(abilityDescriptionLabel)
    }

    private func buildConstraints() {

        NSLayoutConstraint.activate([
        
            abilityImage.topAnchor.constraint(equalTo: self.topAnchor),
            abilityImage.leftAnchor.constraint(equalTo: self.leftAnchor),
            abilityImage.widthAnchor.constraint(equalToConstant: 50),
            abilityImage.heightAnchor.constraint(equalToConstant: 50),
            
            abilityNameLabel.leftAnchor.constraint(equalTo: abilityImage.rightAnchor, constant: 20),
            abilityNameLabel.topAnchor.constraint(equalTo: self.topAnchor),
            abilityNameLabel.rightAnchor.constraint(equalTo: self.rightAnchor),
            
            abilityDescriptionLabel.topAnchor.constraint(equalTo: abilityNameLabel.bottomAnchor, constant: 10),
            abilityDescriptionLabel.leftAnchor.constraint(equalTo: abilityImage.rightAnchor, constant: 20),
            abilityDescriptionLabel.rightAnchor.constraint(equalTo: self.rightAnchor),
            abilityDescriptionLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor)
            
        ])
        
    }

    //MARK: - Setup

    // Your Setup Methods Here

    //MARK: - Configure

    func configure(with vm: AgentAbilityViewVM?) {
        abilityImage.loadImageFromURL(urlString: vm?.item?.displayIcon ?? "")
        abilityNameLabel.text = vm?.item?.displayName
        abilityDescriptionLabel.text = vm?.item?.description
    }

    //MARK: - Actions

    // Your Actions Here
    
}
