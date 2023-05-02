//
//  TvingMenuCollectionViewCell.swift
//  TvingCloneCoding
//
//  Created by uiskim on 2023/05/02.
//

import UIKit

class TvingMenuCollectionViewCell: UICollectionViewCell {
    
    static var cellId = "MenuCollectionViewCell"
    
    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .designSystem(.white)
        label.font = .pretendard(weight: ._400, size: ._17)
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isSelected: Bool {
        didSet {
            titleLabel.font = .pretendard(weight: isSelected ? ._600 : ._400, size: ._17)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
