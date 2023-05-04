//
//  CollectionViewCell.swift
//  TvingCloneCoding
//
//  Created by uiskim on 2023/05/04.
//

import UIKit

import SnapKit

final class CaruselCollectionViewCell: UICollectionViewCell {
    
    static let cellId = "CaruselCollectionViewCell"
    
    var item: CarueselPoster? {
        didSet {
            guard let item else { return }
            posterView.image = item.posterImage
            titleLabel.text = item.title
            contentLabel.text = item.content
        }
    }
    
    // MARK: UI
    private let posterView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .pretendard(weight: ._700, size: ._23)
        label.textColor = .designSystem(.white)
        return label
    }()
    
    private let contentLabel: UILabel = {
        let label = UILabel()
        label.font = .pretendard(weight: ._400, size: ._15)
        label.numberOfLines = 0
        label.textColor = .designSystem(.white)
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
    }
}

private extension CaruselCollectionViewCell {

    func setHierarchy() {
        contentView.addSubview(posterView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(contentLabel)
    }

    func setLayout() {
        posterView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.centerY).offset(140)
            make.leading.equalToSuperview().inset(20)
        }
        
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.leading.equalTo(titleLabel.snp.leading)
        }
    }
}
