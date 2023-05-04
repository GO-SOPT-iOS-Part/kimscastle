//
//  MainPosterCollectionViewCell.swift
//  TvingCloneCoding
//
//  Created by uiskim on 2023/05/04.
//

import UIKit

import SnapKit

final class MainPosterCollectionViewCell: UICollectionViewCell {
    
    static var cellId = "MainPosterCollectionViewCell"
    
    let carusel = CaruselView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews(carusel)
        carusel.snp.makeConstraints { make in
            make.leading.top.trailing.equalToSuperview()
            make.height.equalTo(594)
        }
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
