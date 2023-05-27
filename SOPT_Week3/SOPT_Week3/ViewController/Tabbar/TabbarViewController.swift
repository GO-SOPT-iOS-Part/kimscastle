//
//  TabbarViewController.swift
//  SOPT_Week3
//
//  Created by uiskim on 2023/05/27.
//

import UIKit

class TabbarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let homeViewController = CarrotViewController()
        homeViewController.tabBarItem = UITabBarItem(title: "홈", image: UIImage(systemName: "flame.fill"), tag: 0)
        let releaseVideoViewController = PhotoViewController()
        releaseVideoViewController.tabBarItem = UITabBarItem(title: "공개예정", image: UIImage(systemName: "flame.fill"), tag: 1)
        
        tabBar.barTintColor = .black
        tabBar.isTranslucent = false
        setViewControllers([homeViewController, releaseVideoViewController].map{UINavigationController(rootViewController: $0)}, animated: false)
    }

}

