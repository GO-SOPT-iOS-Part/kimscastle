//
//  UIFont+.swift
//  TvingCloneCoding
//
//  Created by uiskim on 2023/04/12.
//

import UIKit

extension UIFont {
    class func designSystem(weight: Font.Weight, size: Font.Size) -> UIFont {
        .systemFont(ofSize: size.rawValue, weight: weight.real)
    }
    
    class func pretendard(weight: Font.Weight, size: Font.Size) -> UIFont {
        let font = Font.CustomFont(name: .pretendard, weight: weight)
        return ._font(name: font.name, size: size.rawValue)
    }
    
    private static func _font(name: String, size: CGFloat) -> UIFont {
        guard let font = UIFont(name: name, size: size) else {
            return .systemFont(ofSize: size)
        }
        return font
    }
}
