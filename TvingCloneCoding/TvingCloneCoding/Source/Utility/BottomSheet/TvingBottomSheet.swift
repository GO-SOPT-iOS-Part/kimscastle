//
//  TvingBottomSheet.swift
//  TvingCloneCoding
//
//  Created by uiskim on 2023/04/15.
//

import UIKit

final class TvingBottomSheet: UIView {

    init(color: UIColor?, cornerRadius: CGFloat = 26) {
        super.init(frame: .zero)
        self.backgroundColor = color
        self.layer.cornerRadius = cornerRadius
        self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        self.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
