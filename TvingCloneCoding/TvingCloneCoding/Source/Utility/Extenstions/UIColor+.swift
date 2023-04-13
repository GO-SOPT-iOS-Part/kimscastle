//
//  UIColor+.swift
//  TvingCloneCoding
//
//  Created by uiskim on 2023/04/12.
//

import UIKit

extension UIColor {
    class func designSystem(_ color: Palette) -> UIColor? {
        UIColor(named: color.rawValue)
    }
}
