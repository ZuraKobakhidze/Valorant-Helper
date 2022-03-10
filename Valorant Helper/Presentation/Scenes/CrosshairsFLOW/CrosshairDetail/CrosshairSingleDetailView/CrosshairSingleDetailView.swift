import UIKit

class CrosshairSingleDetailView: UIView {
    
    //MARK: - Views

    let topView: UIView = {
        let view = UIView()
        view.backgroundColor = AppColor.darkWhite.color
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let leftView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let leftLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColor.darkWhite.color
        label.font = AppFont.getBold(ofSize: 12)
        label.numberOfLines = 2
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let rightView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let rightLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColor.darkWhite.color
        label.font = AppFont.getBold(ofSize: 12)
        label.numberOfLines = 2
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = AppColor.darkWhite.color
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
        addSubview(leftView)
        leftView.addSubview(leftLabel)
        addSubview(rightView)
        rightView.addSubview(rightLabel)
        addSubview(separatorView)
        addSubview(topView)
    }

    private func buildConstraints() {

        NSLayoutConstraint.activate([
            
            self.heightAnchor.constraint(equalToConstant: 50),
            
            topView.topAnchor.constraint(equalTo: self.topAnchor),
            topView.leftAnchor.constraint(equalTo: self.leftAnchor),
            topView.rightAnchor.constraint(equalTo: self.rightAnchor),
            topView.heightAnchor.constraint(equalToConstant: 2),
        
            leftView.topAnchor.constraint(equalTo: self.topAnchor),
            leftView.leftAnchor.constraint(equalTo: self.leftAnchor),
            leftView.widthAnchor.constraint(equalToConstant: self.frame.width/2),
            leftView.heightAnchor.constraint(equalToConstant: 50),
            
            leftLabel.leftAnchor.constraint(equalTo: leftView.leftAnchor, constant: 10),
            leftLabel.rightAnchor.constraint(equalTo: leftView.rightAnchor, constant: -10),
            leftLabel.centerYAnchor.constraint(equalTo: leftView.centerYAnchor),
            
            rightView.topAnchor.constraint(equalTo: self.topAnchor),
            rightView.rightAnchor.constraint(equalTo: self.rightAnchor),
            rightView.widthAnchor.constraint(equalToConstant: self.frame.width/2),
            rightView.heightAnchor.constraint(equalToConstant: 50),
            
            rightLabel.leftAnchor.constraint(equalTo: rightView.leftAnchor, constant: 10),
            rightLabel.rightAnchor.constraint(equalTo: rightView.rightAnchor, constant: -10),
            rightLabel.centerYAnchor.constraint(equalTo: rightView.centerYAnchor),
            
            separatorView.topAnchor.constraint(equalTo: self.topAnchor),
            separatorView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            separatorView.widthAnchor.constraint(equalToConstant: 2),
            separatorView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
            
        ])
        
    }

    //MARK: - Setup

    func makeViewAsHeader() {
        topView.isHidden = true
        leftView.backgroundColor = AppColor.mediumRed.color
        rightView.backgroundColor = AppColor.mediumRed.color
    }

    //MARK: - Configure

    func configure(with vm: CrosshairDetailModel?) {
        leftLabel.text = vm?.value
        rightLabel.text = vm?.description
    }

    //MARK: - Actions

    // Your Actions Here
    
}
