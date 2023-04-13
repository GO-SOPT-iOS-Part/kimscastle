//
//  CGColor+.swift
//  TvingCloneCoding
//
//  Created by uiskim on 2023/04/13.
//

import UIKit

extension CGColor {
    class func designSystem(_ color: Palette) -> CGColor? {
        UIColor(named: color.rawValue)?.cgColor
    }
}
