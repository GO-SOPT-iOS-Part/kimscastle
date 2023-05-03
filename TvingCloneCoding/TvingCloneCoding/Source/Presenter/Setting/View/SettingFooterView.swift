//
//  SettingFooterView.swift
//  TvingCloneCoding
//
//  Created by uiskim on 2023/04/28.
//

import UIKit

import SnapKit

final class SettingFooterView: UIView {
    
    private let logoutButton = TvingRectangleButton(title: "로그아웃", buttonType: .nonActive)

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .designSystem(.black)
        addSubview(logoutButton)
        logoutButton.addButtonAction { _ in
            print("로그아웃")
        }

    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        logoutButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.leading.trailing.equalToSuperview().inset(10)
            make.height.equalTo(55)
        }
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
