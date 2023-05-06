//
//  TvingImageView.swift
//  TvingCloneCoding
//
//  Created by uiskim on 2023/04/13.
//

import UIKit

final class TvingImageView: UIImageView {

    init(imageName: Constant.ImageName, contentMode: ContentMode) {
        super.init(frame: .zero)
        self.image = .assetImage(imageName)
        self.contentMode = contentMode
    }
    
    init(imageName: UIButton.IconButtonType, tintColor: UIColor? = .designSystem(.gray626262)) {
        super.init(frame: .zero)
        self.image = imageName.buttonImage
        self.contentMode = .scaleAspectFit
        self.tintColor = tintColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
