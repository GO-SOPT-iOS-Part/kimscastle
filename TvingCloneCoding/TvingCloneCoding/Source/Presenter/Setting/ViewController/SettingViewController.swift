//
//  SettingViewController.swift
//  TvingCloneCoding
//
//  Created by uiskim on 2023/04/27.
//

import UIKit

import SnapKit

final class SettingViewController: UIViewController {
    
    enum UserSettingType: String, CaseIterable {
        case ticket = "이용권"
        case inquiryDetails = "1:1 문의내역"
        case reservationAlert = "예약알림"
        case infomationModification = "회원정보 수정"
        case acceptanceAgreement = "프로모션 정보 수신 동의"
    }

    enum AppInfoType: String, CaseIterable {
        case notice = "공지사항"
        case event = "이벤트"
        case customerService = "고객센터"
        case infomation = "티빙 알아보기"
    }
    
    private let data = [UserSettingType.allCases.map {$0.rawValue}, AppInfoType.allCases.map {$0.rawValue}]
    
    private let settingTableView = UITableView(frame: .zero, style: .grouped)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setNavigation()
        setUI()
        setHierarchy()
        setLayout()
        setButtonTarget()
    }


}

private extension SettingViewController {
    func setNavigation() {
        tvingNavigationBar(.designSystem(.white),
                           left: [UIButton.imageButton(.back, action: { _ in self.navigationController?.popViewController(animated: true) })],
                           right: [UIButton.imageButton(.setting, action: { _ in print("알람View로 이동")}),
                                   UIButton.imageButton(.alert, action: { _ in print("설정View로 이동")})])
    }
    
    func setUI() {
    }
    
    func setHierarchy() {
        view.addSubviews(settingTableView)
    }
    
    func setLayout() {
        settingTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func setButtonTarget() {
        
    }
}


