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
    
    //MARK: - Views
    
    lazy var topLineView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 2))
        view.backgroundColor = AppColor.mediumRed.color
        return view
    }()
    
    //MARK: - Variables
    
    let viewControllerCount = 3
    
    //MARK: - Images
    
    let tabBarSelectedImages = [
        AppAsset.tabBarAgentsSelected,
        AppAsset.tabBarCrosshairsSelected,
        AppAsset.tabBarLineUpsSelected
    ]
    
    let tabBarUnselectedImages = [
        AppAsset.tabBarAgentsNotSelected,
        AppAsset.tabBarCrosshairsNotSelected,
        AppAsset.tabBarLineUpsNotSelected
    ]
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBar.backgroundColor = .white
        self.tabBar.addSubview(topLineView)
        setupTabBarItems()
    }
    
    //MARK: - Setup
    
    private func setupTabBarItems() {

        self.setViewControllers([agentsVC, crosshairsVC, lineUpsVC], animated: false)
        setupTabBarTitles()
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
    
    private func setupTabBarTitles() {
        
        let tabBarAppearance = UITabBarAppearance()
        let tabBarItemAppearance = UITabBarItemAppearance()

        tabBarItemAppearance.normal.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: AppColor.lightWhite.color,
            NSAttributedString.Key.font: AppFont.getBold(ofSize: 10)
        ]
        tabBarItemAppearance.selected.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: AppColor.mediumRed.color,
            NSAttributedString.Key.font: AppFont.getBold(ofSize: 10)
        ]

        tabBarAppearance.stackedLayoutAppearance = tabBarItemAppearance
        tabBarAppearance.backgroundColor = AppColor.darkBlack.color

        tabBar.standardAppearance = tabBarAppearance
        if #available(iOS 15.0, *) {
            tabBar.scrollEdgeAppearance = tabBarAppearance
        }
        
    }

}
