//
//  SettingHeaderView.swift
//  TvingCloneCoding
//
//  Created by uiskim on 2023/04/28.
//

import UIKit

import SnapKit

class SettingHeaderView: UIView {
    
    
    private let profileView = SettingProfileView()

    private let userInfoView = UserInfoView()


    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .designSystem(.black)
        addSubviews(profileView, userInfoView)
        profileView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(110)
        }
        userInfoView.snp.makeConstraints { make in
            make.top.equalTo(profileView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(160)
        }

    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        userInfoView.snp.remakeConstraints { make in
            make.top.equalTo(profileView.snp.bottom)
            make.leading.trailing.equalToSuperview().inset(10)
            make.height.equalTo(160)
        }
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
