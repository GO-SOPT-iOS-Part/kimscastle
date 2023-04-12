//
//  UIView+.swift
//  TvingCloneCoding
//
//  Created by uiskim on 2023/04/13.
//

import UIKit

extension UIView {
    func addButtonsInTextfield(views: [UIView]) -> UIView {
        self.frame = .init(x: 0, y: 0, width: views.count * 20, height: 20)
        views.enumerated().forEach { (index, view) in
            view.frame = .init(x: 0 + (index * 20), y: 0, width: 20, height: 20)
            self.addSubview(view)
        }
        return self
    }
}
