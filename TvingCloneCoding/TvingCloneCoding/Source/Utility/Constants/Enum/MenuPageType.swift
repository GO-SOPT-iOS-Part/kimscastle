//
//  MenuPageType.swift
//  TvingCloneCoding
//
//  Created by uiskim on 2023/05/03.
//

import UIKit

@frozen
enum MenuPageType: String, CaseIterable {
    case home = "홈"
    case realTime = "ㅁ실시간"
    case tvProgram = "TV프로그램"
    case movie = "영화"
    case prarmount = "파라마운트+"
    case kid = "키즈"
    
    var viewController: UIViewController {
        switch self {
        case .home:
            return MainViewController(dataFetchable: MainViewDataService.shared)
        case .realTime:
            return RealTimeViewController()
        case .tvProgram:
            return TvProgramViewController()
        case .movie:
            return MovieViewController()
        case .prarmount:
            return ParamountViewController()
        case .kid:
            return KidViewController()
        }
    }
}
