//
//  MainViewController.swift
//  TvingCloneCoding
//
//  Created by uiskim on 2023/04/27.
//

import UIKit

import SnapKit

class MainViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .designSystem(.black)
        setNavigation()
    }
}

private extension MainViewController {
    func setNavigation() {
        let push = { self.navigationController?.pushViewController($0, animated: true)}
        tvingNavigationBar(.designSystem(.white),
                           left: [UIImageView(image: UIImage(named: Constant.ImageName.logo))],
                           right: [UIButton.imageButton(.profile, action: { _ in push(SettingViewController()) })])
    }
}
