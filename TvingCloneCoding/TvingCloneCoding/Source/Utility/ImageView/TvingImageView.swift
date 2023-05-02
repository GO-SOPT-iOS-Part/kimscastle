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
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
