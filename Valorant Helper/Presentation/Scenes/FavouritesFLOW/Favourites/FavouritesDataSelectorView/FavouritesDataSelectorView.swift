import UIKit
import Combine

class FavouritesDataSelectorView: UIView {
    
    //MARK: - Views

    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = AppColor.darkWhite.color
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let leftLabel: UILabel = {
        let label = UILabel()
        label.text = "LINE-UPS".localized()
        label.font = AppFont.getBold(ofSize: 14)
        label.textColor = AppColor.mediumRed.color
        label.numberOfLines = 1
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let rightLabel: UILabel = {
        let label = UILabel()
        label.text = "CROSSHAIRS".localized()
        label.font = AppFont.getBold(ofSize: 14)
        label.textColor = AppColor.extraBlack.color
        label.numberOfLines = 1
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let leftView: UIView = {
        let view = UIView()
        view.backgroundColor = AppColor.mediumRed.color
        view.isHidden = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let rightView: UIView = {
        let view = UIView()
        view.backgroundColor = AppColor.mediumRed.color
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    //MARK: - Variables

    @Published var currentIndex = 0

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
        setupGestureRecognizers()
    }

    //MARK: - Build

    private func buildSubviews() {
        addSubview(containerView)
        containerView.addSubview(leftLabel)
        containerView.addSubview(leftView)
        containerView.addSubview(rightLabel)
        containerView.addSubview(rightView)
    }

    private func buildConstraints() {

        NSLayoutConstraint.activate([
        
            containerView.leftAnchor.constraint(equalTo: self.leftAnchor),
            containerView.topAnchor.constraint(equalTo: self.topAnchor),
            containerView.rightAnchor.constraint(equalTo: self.rightAnchor),
            containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 40),
            
            leftLabel.topAnchor.constraint(equalTo: containerView.topAnchor),
            leftLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor),
            leftLabel.heightAnchor.constraint(equalToConstant: 40),
            leftLabel.widthAnchor.constraint(equalToConstant: (PublicConstants.screenWidth-50)/2),
            
            leftView.leftAnchor.constraint(equalTo: containerView.leftAnchor),
            leftView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            leftView.heightAnchor.constraint(equalToConstant: 2),
            leftView.widthAnchor.constraint(equalToConstant: (PublicConstants.screenWidth-50)/2),
            
            rightLabel.topAnchor.constraint(equalTo: containerView.topAnchor),
            rightLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor),
            rightLabel.heightAnchor.constraint(equalToConstant: 40),
            rightLabel.widthAnchor.constraint(equalToConstant: (PublicConstants.screenWidth-50)/2),
            
            rightView.rightAnchor.constraint(equalTo: containerView.rightAnchor),
            rightView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            rightView.heightAnchor.constraint(equalToConstant: 2),
            rightView.widthAnchor.constraint(equalToConstant: (PublicConstants.screenWidth-50)/2),
        
        ])
        
    }

    //MARK: - Setup

    private func setupGestureRecognizers() {
        
        let leftTapGesture = UITapGestureRecognizer(target: self, action: #selector(onLeft))
        leftLabel.isUserInteractionEnabled = true
        leftLabel.addGestureRecognizer(leftTapGesture)
        
        let rightTapGesture = UITapGestureRecognizer(target: self, action: #selector(onRight))
        rightLabel.isUserInteractionEnabled = true
        rightLabel.addGestureRecognizer(rightTapGesture)
        
    }

    //MARK: - Actions

    @objc func onLeft() {
        if currentIndex != 0 {
            currentIndex = 0
            leftLabel.textColor = AppColor.mediumRed.color
            leftView.isHidden = false
            rightLabel.textColor = AppColor.extraBlack.color
            rightView.isHidden = true
        }
    }
    
    @objc func onRight() {
        if currentIndex != 1 {
            currentIndex = 1
            leftLabel.textColor = AppColor.extraBlack.color
            leftView.isHidden = true
            rightLabel.textColor = AppColor.mediumRed.color
            rightView.isHidden = false
        }
    }
    
}
