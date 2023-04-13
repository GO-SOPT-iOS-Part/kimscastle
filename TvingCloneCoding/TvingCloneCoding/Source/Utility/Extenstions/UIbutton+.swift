//
//  UIbutton+.swift
//  TvingCloneCoding
//
//  Created by uiskim on 2023/04/13.
//

import UIKit

extension UIButton {
    
    enum ButtonActive {
        case active
        case nonActive
    }
    
    func makeActiveTypeButton(activeType: ButtonActive) {
        switch activeType {
        case .active:
            activeButton()
        case .nonActive:
            nonActiveButton()
        }
    }
    
    private func activeButton() {
        self.titleLabel?.font = .pretendard(weight: ._600, size: ._14)
        self.setTitleColor(.designSystem(.white), for: .normal)
        self.backgroundColor = .designSystem(.mainRed)
        self.layer.cornerRadius = 3
        self.isEnabled = true
    }
    
    func nonActiveButton() {
        self.titleLabel?.font = .pretendard(weight: ._600, size: ._14)
        self.setTitleColor(.designSystem(.gray9C9C9C), for: .normal)
        self.backgroundColor = .designSystem(.black)
        self.layer.cornerRadius = 3
        self.layer.borderWidth = 1
        self.layer.borderColor = .designSystem(.gray2E2E2E)
        self.isEnabled = false
    }
}

extension UIButton {
    func setUnderline() {
        guard let title = title(for: .normal) else { return }
        let attributedString = NSMutableAttributedString(string: title)
        attributedString.addAttribute(.underlineStyle,
                                      value: NSUnderlineStyle.single.rawValue,
                                      range: NSRange(location: 0, length: title.count))
        
        setAttributedTitle(attributedString, for: .normal)
    }
}

extension UIButton {
    enum LoginButtonImageType {
        case clear
        case hidePassword
        case showPassword
    }
    
    func setLoginImage(type: LoginButtonImageType) {
        switch type {
        case .clear:
            self.setImage(UIImage(named: Constant.ImageName.clearButton), for: .normal)
        case .hidePassword:
            self.setImage(UIImage(named: Constant.ImageName.hidePasswordButton), for: .selected)
        case .showPassword:
            self.setImage(UIImage(named: Constant.ImageName.showPasswordButton), for: .normal)
        }
    }
}
