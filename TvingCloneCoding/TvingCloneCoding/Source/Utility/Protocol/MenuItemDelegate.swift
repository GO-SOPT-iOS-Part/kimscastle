//
//  MenuItemDelegate.swift
//  TvingCloneCoding
//
//  Created by uiskim on 2023/05/02.
//

import Foundation

protocol MenuItemDelegate: AnyObject {
    func menuView(didSelectItemAt indexPath: IndexPath)
}
