//
//  UIViewController+.swift
//  TvingCloneCoding
//
//  Created by uiskim on 2023/04/15.
//

import UIKit


extension UIViewController {
    func tvingNavigationBar<T: UIView, A: UIView>(_ tintColor: UIColor?, left leftItems: [T], right rightItems: [A]) {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .designSystem(.mainRed)
        self.navigationController?.navigationBar.standardAppearance = appearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
        self.navigationController?.navigationBar.tintColor = tintColor
        self.navigationItem.setLeftBarButtonItems(leftItems.map {UIBarButtonItem(customView: $0)}, animated: false)
        self.navigationItem.setRightBarButtonItems(rightItems.map {UIBarButtonItem(customView: $0)}, animated: false)
    }
}

