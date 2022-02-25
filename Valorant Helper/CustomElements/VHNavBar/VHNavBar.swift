import UIKit

class VHNavBar: UIView {
    
    //MARK: - Views

    let leftItemImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.layer.masksToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let centerItemImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.layer.masksToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    //MARK: - Variables

    // Your Variables Here

    //MARK: - Init

    init() {
        super.init(frame: .zero)

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

    }

    private func buildConstraints() {

    }

    //MARK: - Setup

    // Your Setup Methods Here

    //MARK: - Configure

    func configure(with vm: VHNavBarVM) {
        
    }

    //MARK: - Actions

    // Your Actions Here
    
}
