//
//  QuickVODCollectionViewCell.swift
//  CompositionalLayout
//
//  Created by uiskim on 2023/05/01.
//

import UIKit

import SnapKit

final class QuickVODCollectionViewCell: UICollectionViewCell, CollectionViewCellReuseProtocol {
    
    var data: VideoInfo? {
        didSet {
            guard let data = data else { return }
            guard let imagePath = data.image else { return }
            posterView.setImageUrl(imagePath)
            title.text = data.name
        }
    }
    
    private let posterView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleToFill
        view.clipsToBounds = true
        return view
    }()
    
    private let title: UILabel = {
        let label = UILabel()
        label.font = .pretendard(weight: ._500, size: ._10)
        label.textColor = .designSystem(.white)
        return label
    }()
    
    private let subtitle: UILabel = {
        let label = UILabel()
        label.text = "60화"
        label.font = .pretendard(weight: ._500, size: ._10)
        label.textColor = .designSystem(.gray626262)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setHierarchy()
        setLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        posterView.image = nil
        title.text = nil
    }
}

private extension QuickVODCollectionViewCell {
    func setHierarchy() {
        contentView.addSubview(posterView)
        contentView.addSubview(title)
        contentView.addSubview(subtitle)
    }

    func setLayout() {
        posterView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }
        
        title.snp.makeConstraints { make in
            make.top.equalTo(posterView.snp.bottom)
            make.height.equalTo(17)
            make.leading.trailing.equalToSuperview()
        }
        
        subtitle.snp.makeConstraints { make in
            make.top.equalTo(title.snp.bottom)
            make.leading.equalToSuperview()
            make.height.equalTo(17)
            make.bottom.equalToSuperview()
        }
    }
}
