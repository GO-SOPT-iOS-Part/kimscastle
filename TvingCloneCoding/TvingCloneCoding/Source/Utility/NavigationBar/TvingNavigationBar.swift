//
//  TvingNavigationBar.swift
//  TvingCloneCoding
//
//  Created by uiskim on 2023/05/04.
//

import UIKit

import SnapKit

final class TvingNavigationBar: UIView {

    private let navigationImageView = TvingImageView(imageName: .logo, contentMode: .scaleAspectFit)
    private let bluetoothButton: UIButton = .iconButton(.bluetooth)
    
    init(profileButton: UIButton) {
        super.init(frame: .zero)
        addSubviews(navigationImageView,bluetoothButton,profileButton)
        navigationImageView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview().inset(20)
            make.width.equalTo(100)
        }
        navigationImageView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview().inset(20)
            make.width.equalTo(100)
        }
        bluetoothButton.tintColor = .designSystem(.white)
        bluetoothButton.snp.makeConstraints { make in
            make.centerY.equalTo(navigationImageView.snp.centerY)
            make.trailing.equalTo(profileButton.snp.trailing).offset(-40)
            make.size.equalTo(50)
        }
        
        profileButton.snp.makeConstraints { make in
            make.centerY.equalTo(navigationImageView.snp.centerY)
            make.trailing.equalToSuperview().inset(10)
            make.size.equalTo(50)
        }
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
