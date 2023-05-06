//
//  UserInfoView.swift
//  TvingCloneCoding
//
//  Created by uiskim on 2023/05/04.
//

import UIKit

import SnapKit

final class UserInfoView: UIView {
    
    private let ticketView = ImageLabelView(type: .ticket, content: "사용중인 이용권이 없습니다")
    private let cashView = ImageLabelView(type: .cash, content: "0")
    private let naverMemberShipButton = TvingRectangleButton(title: "네이버플러스 멤버십 변경", buttonType: .nonActive)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .designSystem(.gray2E2E2E)
        addSubviews(ticketView, cashView, naverMemberShipButton)
        ticketView.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(20)
            make.leading.equalTo(self.snp.leading)
            make.trailing.equalTo(self.snp.trailing)
            make.height.equalTo(30)
        }
        cashView.snp.makeConstraints { make in
            make.top.equalTo(ticketView.snp.bottom)
            make.leading.equalTo(self.snp.leading)
            make.trailing.equalTo(self.snp.trailing)
            make.height.equalTo(30)
        }
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        naverMemberShipButton.snp.makeConstraints { make in
            make.top.equalTo(cashView.snp.bottom).offset(10)
            make.height.equalTo(50)
            make.leading.trailing.equalToSuperview().inset(20)
        }
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
