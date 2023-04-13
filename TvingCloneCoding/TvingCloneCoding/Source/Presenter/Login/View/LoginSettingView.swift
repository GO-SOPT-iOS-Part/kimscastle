//
//  LoginSettingView.swift
//  TvingCloneCoding
//
//  Created by uiskim on 2023/04/13.
//

import UIKit

import SnapKit

class LoginSettingView: UIView {

    private let findEmailButton: UIButton = {
        let button = UIButton()
        button.setTitle("아이디 찾기", for: .normal)
        button.titleLabel?.font = .pretendard(weight: ._600, size: ._14)
        button.setTitleColor(.designSystem(.gray9C9C9C), for: .normal)
        button.backgroundColor = .clear
        return button
    }()
    
    private let seperateView: UIView = {
        let view = UIView()
        view.backgroundColor = .designSystem(.gray2E2E2E)
        return view
    }()
    
    private let findPasswordButton: UIButton = {
        let button = UIButton()
        button.setTitle("비밀번호 찾기", for: .normal)
        button.titleLabel?.font = .pretendard(weight: ._600, size: ._14)
        button.setTitleColor(.designSystem(.gray9C9C9C), for: .normal)
        button.backgroundColor = .clear
        return button
    }()
    
    private let noAccountLabel = TvingLabel(title: "아직 계정이 없으신가요?", fontWeight: ._600, fontSize: ._14, fontColor: .gray626262)

    lazy var makeNicknameButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("닉네임 만들러가기", for: .normal)
        button.setTitleColor(.designSystem(.gray9C9C9C), for: .normal)
        button.titleLabel?.font = .pretendard(weight: ._400, size: ._14)
        button.setUnderline()
        return button
    }()
    
    
    init() {
        super.init(frame: .zero)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        self.addSubviews(findEmailButton, seperateView, findPasswordButton, noAccountLabel, makeNicknameButton)
        findEmailButton.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top)
            make.trailing.equalTo(seperateView.snp.leading).offset(-33)
        }
        seperateView.snp.makeConstraints { make in
            make.height.equalTo(12)
            make.width.equalTo(1)
            make.centerY.equalTo(findEmailButton.snp.centerY)
            make.centerX.equalToSuperview()
        }
        
        findPasswordButton.snp.makeConstraints { make in
            make.leading.equalTo(seperateView.snp.trailing).offset(36)
            make.top.equalTo(self.snp.top)
        }
        
        noAccountLabel.snp.makeConstraints { make in
            make.top.equalTo(findEmailButton.snp.bottom).offset(28)
            make.trailing.equalTo(seperateView.snp.trailing)
        }
        
        makeNicknameButton.snp.makeConstraints { make in
            make.centerY.equalTo(noAccountLabel.snp.centerY)
            make.centerX.equalTo(findPasswordButton.snp.centerX)
        }
    }
}
