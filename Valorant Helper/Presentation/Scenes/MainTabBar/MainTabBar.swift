//
//  MainTabBar.swift
//  Valorant Helper
//
//  Created by Zura Kobakhidze on 22.02.22.
//

import UIKit

class MainTabBar: UITabBarController {

    //MARK: - ViewControllers
    
    let agentsVC: UIViewController = {
        let vc = AgentsVC()
        let nav = UINavigationController(rootViewController: vc)
        nav.title = "AGENTS".localized()
        nav.isNavigationBarHidden = true
        return nav
    }()
    
    let crosshairsVC: UIViewController = {
        let vc = CrosshairsVC()
        let nav = UINavigationController(rootViewController: vc)
        nav.title = "CROSSHAIRS".localized()
        nav.isNavigationBarHidden = true
        return nav
    }()
    
    let lineUpsVC: UIViewController = {
        let vc = LineUpsVC()
        let nav = UINavigationController(rootViewController: vc)
        nav.title = "LINE-UPS".localized()
        nav.isNavigationBarHidden = true
        return nav
    }()
    
    let favouritesVC: UIViewController = {
        let vc = FavouritesVC()
        let nav = UINavigationController(rootViewController: vc)
        nav.title = "FAVOURITES".localized()
        nav.isNavigationBarHidden = true
        return nav
    }()
    
    //MARK: - Views
    
    lazy var topLineView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 2))
        view.backgroundColor = AppColor.mediumRed.color
        return view
    }()
    
    //MARK: - Variables
    
    let viewControllerCount = 4
    
    //MARK: - Images
    
    let tabBarSelectedImages = [
        AppAsset.tabBarAgentsSelected,
        AppAsset.tabBarCrosshairsSelected,
        AppAsset.tabBarLineUpsSelected,
        AppAsset.tabBarFavouriteSelected
    ]
    
    let tabBarUnselectedImages = [
        AppAsset.tabBarAgentsNotSelected,
        AppAsset.tabBarCrosshairsNotSelected,
        AppAsset.tabBarLineUpsNotSelected,
        AppAsset.tabBarFavouriteNotSelected
    ]
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBar.addSubview(topLineView)
        setupTabBarItems()
    }
    
    //MARK: - Setup
    
    private func setupTabBarItems() {

        self.setViewControllers([agentsVC, crosshairsVC, lineUpsVC, favouritesVC], animated: false)
        setupTabBarImages()
        
        if let count = self.tabBar.items?.count {
            for i in 0...(count-1) {
                let imageNameForSelectedState   = tabBarSelectedImages[i]
                let imageNameForUnselectedState = tabBarUnselectedImages[i]
                
                self.tabBar.items?[i].selectedImage = imageNameForSelectedState?.withRenderingMode(.alwaysOriginal)
                self.tabBar.items?[i].image = imageNameForUnselectedState?.withRenderingMode(.alwaysOriginal)
            }
        }
        
    }
    
    private func setupTabBarImages() {
        
        guard let items = self.tabBar.items else { return }
        
        for i in 0..<items.count {
            items[i].image = tabBarSelectedImages[i]
        }
        
    }

}

extension UITabBar {
    
    override open var traitCollection: UITraitCollection {
        if UIDevice.current.userInterfaceIdiom == .pad {
            return UITraitCollection(horizontalSizeClass: .compact)
        }
        return super.traitCollection
    }
    
}
