//
//  WeatherSectionView.swift
//  SOPT_Week4
//
//  Created by uiskim on 2023/05/06.
//

import UIKit

import SnapKit

final class WeatherSectionView: UIView {
    
    var data: String? {
        didSet {
            detailLabel.text = data
        }
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .medium)
        return label
    }()
    
    private let detailLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 25, weight: .bold)
        return label
    }()

    init(title: String) {
        titleLabel.text = title
        super.init(frame: .zero)
        
        backgroundColor = .gray
        self.layer.cornerRadius = 20
        self.layer.masksToBounds = true
        
        [titleLabel, detailLabel].forEach{ addSubview($0) }
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.leading.equalToSuperview().inset(20)

        }
        
        detailLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().inset(20)
        }
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
