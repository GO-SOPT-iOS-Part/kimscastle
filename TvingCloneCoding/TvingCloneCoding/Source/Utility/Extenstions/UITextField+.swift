//
//  UITextField+.swift
//  TvingCloneCoding
//
//  Created by uiskim on 2023/04/13.
//

import UIKit

extension UITextField {
    func makeTextFieldFocused() {
        self.makeCornerRadiusWithBorderColor(color: .designSystem(.gray9C9C9C), width: 1)
    }
    
    func makeTextFieldNormal() {
        self.makeCornerRadiusWithBorderColor(color: nil)
    }
    
    private func makeCornerRadiusWithBorderColor(radius: CGFloat = 3, color: CGColor?, width: CGFloat = 0) {
        self.layer.cornerRadius = radius
        self.layer.borderColor = color
        self.layer.borderWidth = width
    }
}

extension UITextField {
    func setLoginPlaceholder(placeholder: String) {
        self.attributedPlaceholder = NSAttributedString(string: placeholder,
                                                        attributes: [.foregroundColor: UIColor.designSystem(.gray9C9C9C)!,
                                                                     .font: UIFont.pretendard(weight: ._600, size: ._15)])
    }
}
