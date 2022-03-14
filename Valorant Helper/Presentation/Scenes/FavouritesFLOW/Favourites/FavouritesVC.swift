import UIKit

class FavouritesVC: UIViewController {
    
    //MARK: - Views

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

    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = AppColor.darkBlack.color
        buildSubviews()
        viewModel.read()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
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

    // Your Configure Methods Here

    //MARK: - Actions

    // Your Actions Here
    
}

    //MARK: - DataSource, Delegate

extension FavouritesVC: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
}
