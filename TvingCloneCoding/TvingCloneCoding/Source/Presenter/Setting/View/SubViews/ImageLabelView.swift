//
//  ImageLabelView.swift
//  TvingCloneCoding
//
//  Created by uiskim on 2023/05/04.
//

import UIKit

final class ImageLabelView: UIView {

    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .designSystem(.gray626262)
        label.sizeToFit()
        label.font = .pretendard(weight: ._500, size: ._14)
        return label
    }()
    
    private let imageView: UIImageView = UIImageView()
    
    private var contentLabel: UILabel = {
        let label = UILabel()
        label.sizeToFit()
        label.font = .pretendard(weight: ._500, size: ._14)
        return label
    }()
    
    init(type: UserInfoType, content: String) {
        super.init(frame: .zero)
        self.imageView.image = type.image
        imageView.contentMode = .scaleAspectFit
        self.label.text = type.title
        self.contentLabel.textColor = type.titleColor
        self.contentLabel.text = content
        
        
        addSubviews(label, imageView, contentLabel)
        imageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(20)
            make.centerY.equalToSuperview()
            make.size.equalTo(20)
        }
        
        label.snp.makeConstraints { make in
            make.leading.equalTo(imageView.snp.trailing).offset(10)
            make.centerY.bottom.equalToSuperview()
            
        }
        contentLabel.snp.makeConstraints { make in
            make.centerY.equalTo(label.snp.centerY)
            make.trailing.equalToSuperview().inset(20)
        }
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
