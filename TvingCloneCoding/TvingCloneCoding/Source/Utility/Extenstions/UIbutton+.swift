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
            
        var isEnabled: Bool {
            switch self {
            case .active:
                return true
            case .nonActive:
                return false
            }
        }
        
        var titleColor: UIColor? {
            switch self {
            case .active:
                return .designSystem(.white)
            case .nonActive:
                return .designSystem(.gray9C9C9C)
            }
        }
        
        var backgroundColor: UIColor? {
            switch self {
            case .active:
                return .designSystem(.mainRed)
            case .nonActive:
                return .designSystem(.black)
            }
        }
    }
    
    func makeActiveTypeButton(activeType: ButtonActive) {
        self.layer.cornerRadius = 3
        self.titleLabel?.font = .pretendard(weight: ._600, size: ._14)
        configureButton(status: activeType)
    }
    
    private func configureButton(status: ButtonActive) {
        self.isEnabled = status.isEnabled
        self.setTitleColor(status.titleColor, for: .normal)
        self.backgroundColor = status.backgroundColor
        self.setBorderInButton(isActive: status.isEnabled)
    }
    
    private func setBorderInButton(isActive: Bool) {
        if !isActive {
            self.layer.borderWidth = 1
            self.layer.borderColor = .designSystem(.gray2E2E2E)
        }
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
        
        var loginImage: UIImage? {
            switch self {
            case .clear:
                return UIImage(named: Constant.ImageName.clearButton)
            case .hidePassword:
                return UIImage(named: Constant.ImageName.hidePasswordButton)
            case .showPassword:
                return UIImage(named: Constant.ImageName.showPasswordButton)
            }
        }
        
        var controlState: UIControl.State {
            switch self {
            case .clear:
                return .normal
            case .hidePassword:
                return .selected
            case .showPassword:
                return .normal
            }
        }
    }
    
    func setLoginImage(type: LoginButtonImageType) {
        self.setImage(type.loginImage, for: type.controlState)
    }
}
