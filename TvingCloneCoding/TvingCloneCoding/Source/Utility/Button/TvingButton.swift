//
//  TvingButton.swift
//  TvingCloneCoding
//
//  Created by uiskim on 2023/04/13.
//

import UIKit

final class TvingButton: UIButton {
    
    init(title: String, buttonType: ButtonActive) {
        super.init(frame: .zero)
        self.setTitle(title, for: .normal)
        self.makeActiveTypeButton(activeType: buttonType)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
