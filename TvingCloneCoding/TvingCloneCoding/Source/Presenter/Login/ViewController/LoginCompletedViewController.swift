//
//  LoginCompletedViewController.swift
//  TvingCloneCoding
//
//  Created by uiskim on 2023/04/13.
//

import UIKit

import SnapKit

final class LoginCompletedViewController: UIViewController {
    
    var userNickName: String? {
        didSet {
            guard let userNickName else { return }
            userNicNameLabel.text = userNickName + "님" + "\n반가워요"
        }
    }

    private lazy var tvingMainImageView = TvingImageView(imageName: Constant.ImageName.tvingMainImage, contentMode: .scaleAspectFill)
    private lazy var userNicNameLabel = TvingLabel(fontWeight: ._700, fontSize: ._23, fontColor: .grayD6D6D6)
    private lazy var presentMainViewControllerButton = TvingRectangleButton(title: Constant.ButtonTitle.presentMainButtonTitle, buttonType: .active)

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setHierarchy()
        setLayout()
        setButtonTarget()
    }

}

private extension LoginCompletedViewController {
    
    func setUI() {
        view.backgroundColor = .designSystem(.black)
    }
    
    func setHierarchy() {
        view.addSubviews(tvingMainImageView, userNicNameLabel, presentMainViewControllerButton)
    }

    func setLayout() {
        tvingMainImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
        }
        
        userNicNameLabel.snp.makeConstraints { make in
            make.top.equalTo(tvingMainImageView.snp.bottom).offset(67)
            make.leading.trailing.equalToSuperview().inset(75)
        }
        
        presentMainViewControllerButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(66)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(52)
        }
    }
    
    func setButtonTarget() {
        presentMainViewControllerButton.addButtonAction { sender in
            let mainViewController = MainViewController()
            self.navigationController?.pushViewController(mainViewController, animated: true)
        }
    }
}
