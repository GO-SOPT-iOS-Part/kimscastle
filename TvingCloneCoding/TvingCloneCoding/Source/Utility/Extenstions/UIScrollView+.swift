//
//  UIScrollView+.swift
//  TvingCloneCoding
//
//  Created by uiskim on 2023/05/04.
//

import UIKit

extension UIScrollView {
    func move(to: Double, animation: Bool = false) {
        self.setContentOffset(.init(x: to, y: self.contentOffset.y), animated: animation)
    }
}
