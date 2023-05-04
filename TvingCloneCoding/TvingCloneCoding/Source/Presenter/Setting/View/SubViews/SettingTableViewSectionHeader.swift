//
//  SettingTableViewSectionHeader.swift
//  TvingCloneCoding
//
//  Created by uiskim on 2023/05/04.
//

import UIKit

import SnapKit

final class SettingTableViewSectionHeader: UIView {
    
    var lineHidden: Bool? {
        didSet {
            guard let lineHidden = lineHidden else { return }
            line.isHidden = lineHidden
        }
    }
    
    private let line: UIView = {
        let view = UIView()
        view.backgroundColor = .designSystem(.gray626262)
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .designSystem(.black)
        addSubview(line)
        line.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(15)
            make.centerY.equalToSuperview()
            make.height.equalTo(1)
        }
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
