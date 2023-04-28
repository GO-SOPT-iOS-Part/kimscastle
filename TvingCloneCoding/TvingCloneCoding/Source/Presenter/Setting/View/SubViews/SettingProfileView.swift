//
//  SettingProfileView.swift
//  TvingCloneCoding
//
//  Created by uiskim on 2023/04/28.
//

import UIKit

class SettingProfileView: UIView {
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: Constant.ImageName.bigProfileImage))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let nickNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Doosan"
        label.font = .pretendard(weight: ._500, size: ._17)
        label.textColor = .designSystem(.white)
        return label
    }()
    
    private let changeProfileButton = TvingRectangleButton(title: "프로필전환", buttonType: .nonActive)

    override init(frame: CGRect) {
        super.init(frame: frame)

        setUI()
        setHierarchy()
        setLayout()
        setButtonTarget()

    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension SettingProfileView {
    func setUI() {
        backgroundColor = .designSystem(.black)
    }
    
    func setHierarchy() {
        addSubviews(profileImageView, nickNameLabel, changeProfileButton)
    }
    
    func setLayout() {
        
    }
    
    func setButtonTarget() {
        changeProfileButton.addButtonAction { _ in
            print("프로필전환 버튼이 눌림")
        }
    }
}
