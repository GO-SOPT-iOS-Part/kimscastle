//
//  ScrollDelegate.swift
//  TvingCloneCoding
//
//  Created by uiskim on 2023/05/12.
//

import Foundation

protocol ScrollDelegate: AnyObject {
    func scroll(yContentOffset: CGFloat)
}
