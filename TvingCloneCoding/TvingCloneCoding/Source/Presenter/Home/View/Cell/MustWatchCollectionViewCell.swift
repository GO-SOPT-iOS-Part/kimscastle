//
//  MustWatchCollectionViewCell.swift
//  CompositionalLayout
//
//  Created by uiskim on 2023/05/01.
//

import UIKit

import SnapKit

final class MustWatchCollectionViewCell: UICollectionViewCell, CollectionViewCellReuseProtocol {
    
    private var task: URLSessionDataTask?
    
    var data: VideoInfo? {
        didSet {
            guard let data = data else { return }
            guard let imagePath = data.image else { return }
            if task == nil {
                task = posterView.loadImage(from: imagePath)
            }
            title.text = data.name
        }
    }
    
    private let posterView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        return view
    }()
    
    private let title: UILabel = {
        let label = UILabel()
        label.textColor = .designSystem(.white)
        label.font = .pretendard(weight: ._500, size: ._10)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setHierarchy()
        setLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        task?.cancel()
        task = nil
        posterView.image = nil
        title.text = nil
    }
    
}

private extension MustWatchCollectionViewCell {
    func setUI() {
        backgroundColor = .designSystem(.black)
    }
    
    func setHierarchy() {
        contentView.addSubview(posterView)
        contentView.addSubview(title)
    }
    
    func setLayout() {
        posterView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }
        
        title.snp.makeConstraints { make in
            make.top.equalTo(posterView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(17)
        }
    }


}
