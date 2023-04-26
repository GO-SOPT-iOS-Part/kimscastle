//
//  UIView+.swift
//  SOPT_Week3
//
//  Created by uiskim on 2023/04/22.
//

import UIKit

extension UIView {
    func makeRounded(radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
}
