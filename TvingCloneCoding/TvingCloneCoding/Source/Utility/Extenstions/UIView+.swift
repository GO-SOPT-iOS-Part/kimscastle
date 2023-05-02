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
    
    func addSubviews(_ views: UIView...) {
        views.forEach { self.addSubview($0) }
    }
}

extension UIView {
    /// 해당View의 SafeArea Height를 반환해주는 계산속성
    var safeAreaHeight: CGFloat {
        return self.safeAreaLayoutGuide.layoutFrame.size.height
    }
}
