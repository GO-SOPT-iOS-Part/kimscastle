//
//  PosterType.swift
//  TvingCloneCoding
//
//  Created by uiskim on 2023/05/04.
//

import UIKit

enum PosterType {
    case header
    case vertical
    case horizontal
    
    var groupHeight: Double {
        switch self {
        case .header:
            return 654
        case .vertical:
            return 180
        case .horizontal:
            return 130
        }
    }
    
    var groupWidth: Double {
        switch self {
        case .header:
            return Constant.Screen.width
        case .vertical:
            return Constant.Screen.width/3.5
        case .horizontal:
            return Constant.Screen.width/2.0
        }
    }
    
    func headerHeight(height: CGFloat) -> CGFloat {
        switch self {
        case .header:
            return 1
        case .vertical, .horizontal:
            return height
        }
    }
    
    var itemContentInset: NSDirectionalEdgeInsets {
        switch self {
        case .header:
            return .zero
        case .vertical, .horizontal:
            return .init(top: 10, leading: 5, bottom: 10, trailing: 5)
        }
    }
    
    var sectionContentInset: NSDirectionalEdgeInsets {
        switch self {
        case .header:
            return .zero
        case .vertical, .horizontal:
            return .init(top: 0, leading: 0, bottom: 20, trailing: 0)
        }
    }
}

