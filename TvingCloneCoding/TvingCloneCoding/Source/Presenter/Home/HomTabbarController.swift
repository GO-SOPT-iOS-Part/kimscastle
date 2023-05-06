//
//  HomTabbarController.swift
//  TvingCloneCoding
//
//  Created by uiskim on 2023/05/04.
//

import UIKit

final class HomTabbarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let homeViewController = HomeViewController()
        homeViewController.tabBarItem = UITabBarItem(title: "홈", image: .sfImage(.home), tag: 0)
        let releaseVideoViewController = ReleaseVideoViewController()
        releaseVideoViewController.tabBarItem = UITabBarItem(title: "공개예정", image: .sfImage(.release), tag: 1)
        let searchViewController = SearchViewController()
        searchViewController.tabBarItem = UITabBarItem(title: "검색", image: .sfImage(.search), tag: 2)
        let recordViewController = RecordViewController()
        recordViewController.tabBarItem = UITabBarItem(title: "기록", image: .sfImage(.record), tag: 3)
        
        tabBar.barTintColor = .designSystem(.black)
        tabBar.isTranslucent = false
        setViewControllers([homeViewController, releaseVideoViewController, searchViewController, recordViewController].map{UINavigationController(rootViewController: $0)}, animated: false)
    }
}
