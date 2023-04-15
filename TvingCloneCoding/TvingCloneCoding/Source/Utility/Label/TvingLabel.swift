//
//  TvingLabel.swift
//  TvingCloneCoding
//
//  Created by uiskim on 2023/04/13.
//

import UIKit

final class TvingLabel: UILabel {
    
    init(title: String = "", fontWeight: Font.Weight, fontSize: Font.Size, fontColor: Palette) {
        super.init(frame: .zero)
        self.text = title
        self.font = .pretendard(weight: fontWeight, size: fontSize)
        self.textAlignment = .center
        self.textColor = .designSystem(fontColor)
        self.numberOfLines = 0
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
