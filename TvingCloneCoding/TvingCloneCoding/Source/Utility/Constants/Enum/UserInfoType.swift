//
//  UserInfoType.swift
//  TvingCloneCoding
//
//  Created by uiskim on 2023/05/04.
//

import UIKit

enum UserInfoType {
    case cash
    case ticket
    
    var image: UIImage? {
        switch self {
        case .cash:
            return .assetImage(.cashImage)
        case .ticket:
            return .assetImage(.ticketImage)
        }
    }
    
    var title: String {
        switch self {
        case .cash:
            return "티빙 캐시"
        case .ticket:
            return "나의 이용권"
        }
    }
    
    var titleColor: UIColor? {
        switch self {
        case .cash:
            return .designSystem(.white)
        case .ticket:
            return .designSystem(.gray626262)
        }
    }
}
