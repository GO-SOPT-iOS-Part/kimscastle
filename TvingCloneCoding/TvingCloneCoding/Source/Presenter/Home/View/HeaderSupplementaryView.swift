//
//  HeaderSupplementaryView.swift
//  TvingCloneCoding
//
//  Created by uiskim on 2023/05/04.
//

import UIKit

import SnapKit

final class HeaderSupplementaryView: UICollectionReusableView {
    
    var title: String? {
        didSet {
            guard let title = title else { return }
            sectionTitle.text = title
        }
    }
    
    static var viewId = "HeaderSupplementaryView"
    
    private var uiview = CaruselView()
    
    private let sectionTitle: UILabel = {
        let label = UILabel()
        label.textColor = .designSystem(.white)
        label.font = .pretendard(weight: ._500, size: ._15)
        return label
    }()
    
    private let showAllLabel: UILabel = {
        let label = UILabel()
        label.text = "전체보기 >"
        label.font = .pretendard(weight: ._500, size: ._14)
        label.textColor = .designSystem(.gray626262)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setHierarchy()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setHierarchy() {
        addSubview(sectionTitle)
        addSubview(showAllLabel)
    }
    
    private func setLayout() {
        sectionTitle.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(10)
            make.bottom.equalToSuperview()
            make.height.equalTo(20)
        }
        
        showAllLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(10)
            make.bottom.equalToSuperview()
            make.height.equalTo(20)
        }
    }
}
