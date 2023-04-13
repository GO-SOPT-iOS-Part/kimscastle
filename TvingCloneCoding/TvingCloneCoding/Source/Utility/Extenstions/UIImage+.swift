//
//  UIImage+.swift
//  TvingCloneCoding
//
//  Created by uiskim on 2023/04/13.
//

import UIKit

extension UIImage {
    
    enum LoginButtonImageType {
        case clear
        case hidePassword
        case showPassword
    }
    
    static func makeLoginImage(type: LoginButtonImageType) -> UIImage? {
        switch type {
        case .clear:
            return UIImage(named: Constant.ImageName.clearButton)
        case .hidePassword:
            return UIImage(named: Constant.ImageName.hidePasswordButton)
        case .showPassword:
            return UIImage(named: Constant.ImageName.showPasswordButton)
        }
    }
    
    static var setNavigationBackButtonImage: UIImage? {
        return UIImage(named: Constant.ImageName.backButton)
    }
}
