//
//  UIViewController+.swift
//  TvingCloneCoding
//
//  Created by uiskim on 2023/04/15.
//

import UIKit


extension UIViewController {
    
    func moveVerticalPosition(views: UIView..., distance: CGFloat) {
        views.forEach { $0.transform = CGAffineTransform(translationX: 0, y: distance) }
    }
    
    func resetPosition(views: UIView...) {
        views.forEach { $0.transform = .identity }
    }
}

