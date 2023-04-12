//
//  UIbutton+.swift
//  TvingCloneCoding
//
//  Created by uiskim on 2023/04/13.
//

import UIKit

extension UIButton {
    
    enum ButtonActive {
        case active
        case nonActive
    }
    
    func makeActiveTypeButton(activeType: ButtonActive) {
        switch activeType {
        case .active:
            self.setTitleColor(.white, for: .normal)
            self.backgroundColor = .red
            self.isEnabled = true
        case .nonActive:
            self.setTitleColor(.gray, for: .normal)
            self.backgroundColor = .black
            self.isEnabled = false
        }
    }
}
