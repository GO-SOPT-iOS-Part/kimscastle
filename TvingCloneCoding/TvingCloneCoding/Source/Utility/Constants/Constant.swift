//
//  Constant.swift
//  TvingCloneCoding
//
//  Created by uiskim on 2023/04/13.
//

import UIKit

struct Constant {
    enum ImageName: String {
        /// 버튼이미지
        case clearButton = "x-circle"
        case hidePasswordButton = "eye-off"
        case showPasswordButton = "eye"
        case backButton = "NavigationBackButton"
        case tvingMainImage = "TvingMainImage"
        case alertImage = "alert"
        case settingImage = "setting"
        case cashImage = "cash"
        case ticketImage = "ticket"
        case smallProfileImage = "SmallProfileImage"
        case bigProfileImage = "BigProfileImage"
        case logo = "TvingLogo"
        
        
        /// Carusel이미지
        case poster1 = "poster1"
        case poster2 = "poster2"
        case poster3 = "poster3"
        case poster4 = "poster4"
        
        /// Program이미지
        case program1 = "program1"
        case program2 = "program2"
        case program3 = "program3"
        case program4 = "program4"
        
        /// tabbar이미지
        case home = "house.fill"
        case release = "video"
        case search = "magnifyingglass"
        case record = "clock"
        
        var real: String {
            return self.rawValue
        }
    }
    
    struct ButtonTitle {
        static let loginButtonTitle = "로그인하기"
        static let presentMainButtonTitle = "메인으로"
    }
    
    struct Screen {
        static let width = UIScreen.main.bounds.width
        static let height = UIScreen.main.bounds.height
    }
    
    struct Size {
        static let width = UIScreen.main.bounds.width
        static let height = UIScreen.main.bounds.height
    }
    
}
