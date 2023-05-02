//
//  UIbutton+.swift
//  TvingCloneCoding
//
//  Created by uiskim on 2023/04/13.
//

import UIKit

extension UIButton {
    
    @frozen
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
    
    enum ButtonSize {
        case small
        case big
        
        var weight: Font.Weight {
            switch self {
            case .small : return ._500
            case .big : return ._600
            }
        }
        
        var size: Font.Size {
            switch self {
            case .small : return ._10
            case .big : return ._14
            }
        }
    }
    
    func makeActiveTypeButton(activeType: ButtonActive, size: ButtonSize = .big) {
        self.layer.cornerRadius = 3
        self.titleLabel?.font = .pretendard(weight: size.weight, size: size.size)
        configureButton(status: activeType)
    }
    
    private func configureButton(status: ButtonActive) {
        self.isEnabled = status.isEnabled
        self.setTitleColor(status.titleColor, for: .normal)
        self.backgroundColor = status.backgroundColor
        self.setBorderInButton(isActive: status.isEnabled)
    }
    
    private func setBorderInButton(isActive: Bool) {
        self.layer.borderWidth = isActive ? 0 : 1
        if !isActive {
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
    
    @frozen
    enum LoginButtonImageType {
        case clear
        case hidePassword
        case showPassword
        
        var loginImage: UIImage? {
            switch self {
            case .clear:
                return .assetImage(.clearButton)
            case .hidePassword:
                return .assetImage(.hidePasswordButton)
            case .showPassword:
                return .assetImage(.showPasswordButton)
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

extension UIButton {
    enum IconButtonType {
        case back
        case alert
        case setting
        case profile
        
        var buttonImage: UIImage? {
            switch self {
            case .back:
                return .assetImage(.backButton)
            case .alert:
                return .assetImage(.alertImage)
            case .setting:
                return .assetImage(.settingImage)
            case .profile:
                return .assetImage(.smallProfileImage)
            }
        }
    }
    
    
    /// icon모양의 버튼을 만들어주는 함수
    /// - Parameters:
    ///   - type: 이미지를 바로 리턴해주는 변수
    ///   - tintColor: 버튼의 tint color
    ///   - action: 버튼의 액션을 처리해주는 함수
    /// - Returns: uibutton
    static func iconButton(_ type: IconButtonType, _ tintColor: UIColor? = .designSystem(.white), action: @escaping ButtonAction) -> UIButton {
        let button = UIButton()
        button.setImage(type.buttonImage, for: .normal)
        button.tintColor = tintColor
        button.addButtonAction(action)
        return button
    }
    
}
