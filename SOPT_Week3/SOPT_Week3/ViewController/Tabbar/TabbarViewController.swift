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
        releaseVideoViewController.tabBarItem = UITabBarItem(title: "컬렉션", image: UIImage(systemName: "flame.fill"), tag: 1)
        
        let realmVideoViewController = RealmTestViewController()
        releaseVideoViewController.tabBarItem = UITabBarItem(title: "렘", image: UIImage(systemName: "flame.fill"), tag: 2)
        
        tabBar.barTintColor = .black
        tabBar.isTranslucent = false
        setViewControllers([homeViewController, releaseVideoViewController, realmVideoViewController].map{UINavigationController(rootViewController: $0)}, animated: false)
    }

}

