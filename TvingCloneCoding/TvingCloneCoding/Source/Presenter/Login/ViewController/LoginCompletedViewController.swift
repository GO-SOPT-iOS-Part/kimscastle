//
//  LoginCompletedViewController.swift
//  TvingCloneCoding
//
//  Created by uiskim on 2023/04/13.
//

import UIKit

import SnapKit

final class LoginCompletedViewController: UIViewController {
    
    var userEmail: String? {
        didSet {
            guard let userEmail else { return }
            userEmailLabel.text = userEmail + "님" + "\n반가워요"
        }
    }

    private lazy var tvingMainImageView = TvingImageView(imageName: Constant.ImageName.tvingMainImage, contentMode: .scaleAspectFill)
    private lazy var userEmailLabel = TvingLabel(fontWeight: ._700, fontSize: ._23, fontColor: .grayD6D6D6)
    private lazy var presentMainViewControllerButton = TvingButton(title: Constant.ButtonTitle.presentMainButtonTitle, buttonType: .active)

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    
    
    private func setUI() {
        view.backgroundColor = .designSystem(.black)
        view.addSubviews(tvingMainImageView, userEmailLabel, presentMainViewControllerButton)
        tvingMainImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
        }
        userEmailLabel.snp.makeConstraints { make in
            make.top.equalTo(tvingMainImageView.snp.bottom).offset(67)
            make.leading.trailing.equalToSuperview().inset(75)
        }
        presentMainViewControllerButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(66)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(52)
        }
        presentMainViewControllerButton.addTarget(self, action: #selector(presentMainViewControllerButtonTapped(_:)), for: .touchUpInside)
    }
     
    @objc func presentMainViewControllerButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}
