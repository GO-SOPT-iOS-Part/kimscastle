//
//  SettingHeaderView.swift
//  TvingCloneCoding
//
//  Created by uiskim on 2023/04/28.
//

import UIKit

class SettingHeaderView: UIView {

    enum TicketType {
        case week
        case month
        case year
        case none
        
        var ticketTitle: String {
            switch self {
            case .week : return "일주일 이용권을 사용중입니다."
            case .month : return "한달 이용권을 사용중입니다."
            case .year : return "일년 이용권을 사용중입니다."
            case .none : return "사용중인 이용권이 없습니다."
            }
        }
    }
    
    var myCash: Int
    var myTicket: TicketType
    
//    let profileView
//    
//    let userInfoView
//    
//    let adInfoView
    
    
    init(myCash: Int, myTicket: TicketType) {
        self.myCash = myCash
        self.myTicket = myTicket
        super.init(frame: .zero)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
