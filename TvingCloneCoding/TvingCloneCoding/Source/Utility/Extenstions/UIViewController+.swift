//
//  UIViewController+.swift
//  TvingCloneCoding
//
//  Created by uiskim on 2023/04/15.
//

import UIKit


extension UIViewController {
    func tvingNavigationBar(_ tintColor: UIColor?, left leftItems: [some UIView], right rightItems: [some UIView], spacing: CGFloat) {
        typealias MakeStackViewClosure<T: UIView> = ([T], CGFloat) -> UIStackView
        let makeStackView: MakeStackViewClosure = { views, spacing in
            return {
                let stackView = UIStackView(arrangedSubviews: views)
                stackView.distribution = .equalSpacing
                stackView.axis = .horizontal
                stackView.alignment = .center
                stackView.spacing = spacing
                return stackView
            }()
        }
        self.navigationController?.navigationBar.tintColor = tintColor
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: makeStackView(rightItems, spacing))
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: makeStackView(leftItems, spacing))
        
    }
}

