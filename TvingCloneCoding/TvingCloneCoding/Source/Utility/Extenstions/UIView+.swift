//
//  UIView+.swift
//  TvingCloneCoding
//
//  Created by uiskim on 2023/04/13.
//

import UIKit

extension UIView {
    func addButtonsInTextfield(views: [UIView], padding: Int, buttonImageSize: Int = 20, buttonInterval: Int = 16) -> UIView {
        let frameWidth = buttonInterval/2 + (buttonImageSize * views.count) + ((views.count-1) * buttonInterval) + padding
        self.frame = .init(x: 0,
                           y: 0,
                           width: frameWidth,
                           height: buttonImageSize)
        
        views.enumerated().forEach { (index, view) in
            if index == 0 {
                view.frame = .init(x: (buttonInterval/2),
                                   y: 0,
                                   width: buttonImageSize,
                                   height: buttonImageSize)
            } else {
                view.frame = .init(x: buttonInterval/2 + (buttonImageSize+buttonInterval)*index,
                                   y: 0,
                                   width: buttonImageSize,
                                   height: buttonImageSize)
            }
            self.addSubview(view)
        }
        return self
    }
}

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach { self.addSubview($0) }
    }
}

extension UIView {
    /// 해당View의 SafeArea Height를 반환해주는 계산속성
    var safeAreaHeight: CGFloat {
        let verticalSafeAreaInset = self.safeAreaInsets.bottom + self.safeAreaInsets.top
        let safeAreaHeight = self.frame.height - verticalSafeAreaInset
        return safeAreaHeight
    }
}
//
//let verticalSafeAreaInset: CGFloat
//if #available(iOS 11.0, *) {
//  verticalSafeAreaInset = self.view.safeAreaInsets.bottom + self.view.safeAreaInsets.top
//} else {
//  verticalSafeAreaInset = 0.0
//}
//let safeAreaHeight = self.view.frame.height - verticalSafeAreaInset
