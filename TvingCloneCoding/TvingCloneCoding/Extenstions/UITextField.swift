//
//  UITextField.swift
//  TvingCloneCoding
//
//  Created by uiskim on 2023/04/13.
//

import UIKit

extension UITextField {
    func makeTextFieldFocused() {
        self.makeCornerRadiusWithBorderColor(color: .red, width: 2)
    }
    
    func makeTextFieldNormal() {
        self.makeCornerRadiusWithBorderColor(color: .clear)
    }
    
    private func makeCornerRadiusWithBorderColor(radius: CGFloat = 2, color: UIColor, width: CGFloat = 0) {
        self.layer.cornerRadius = radius
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = width
    }
}
