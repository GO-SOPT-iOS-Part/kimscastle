//
//  HeaderSupplementaryView.swift
//  TvingCloneCoding
//
//  Created by uiskim on 2023/05/04.
//

import UIKit

import SnapKit

class HeaderSupplementaryView: UICollectionReusableView {
    
    static var viewId = "HeaderSupplementaryView"
    
    var isFirst: Bool = false {
        didSet {
            guard isFirst == true else { return }
            setHeaderView()
        }
    }
    
    lazy var uiview = CaruselView()
    
    let title: UILabel = {
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
        addSubview(title)
        addSubview(showAllLabel)
        title.snp.makeConstraints { make in
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
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setHeaderView() {
        addSubview(uiview)
        uiview.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(50)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(594)
        }
    }
}
