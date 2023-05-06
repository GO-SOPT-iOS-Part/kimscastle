//
//  TvingRectangleButton.swift
//  TvingCloneCoding
//
//  Created by uiskim on 2023/04/13.
//

import UIKit

final class TvingRectangleButton: UIButton {
    
    init(title: String, buttonType: ButtonActive, size: ButtonSize = .big) {
        super.init(frame: .zero)
        self.setTitle(title, for: .normal)
        self.makeActiveTypeButton(activeType: buttonType, size: size)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
