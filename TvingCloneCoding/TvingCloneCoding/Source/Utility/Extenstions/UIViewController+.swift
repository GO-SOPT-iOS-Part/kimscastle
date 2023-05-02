//
//  UIViewController+.swift
//  TvingCloneCoding
//
//  Created by uiskim on 2023/04/15.
//

import UIKit


extension UIViewController {
    /// ViewControlle에 NavigationBar를 setting해주는 함수
    /// - Parameters:
    ///   - tintColor: Bar의 tint Color 설정
    ///   - leftItems: UIView를 상속받고있는 어떤 클래스(UIButton, UIImageView etc...)든 상관없이 넣어주면됨( 단 하나의 타입으로만 넣어줄수있음 버튼이면 버튼만, 이미지뷰면 이미지뷰만)
    ///   - rightItems: leftItems와 동일
    ///   - spacing: item간의 간격을 넣어주면됨
    func tvingNavigationBar(_ tintColor: UIColor?, left leftItems: [some UIView], right rightItems: [some UIView], spacing: CGFloat) {
        typealias MakeStackViewClosure<T: UIView> = ([T], CGFloat) -> UIStackView
        let makeStackView: MakeStackViewClosure = { views, spacing in
            return {
                let stackView = UIStackView(arrangedSubviews: views)
                stackView.distribution = .equalSpacing
                stackView.axis = .horizontal
                stackView.alignment = .center
                stackView.spacing = spacing
                return stackView
            }()
        }
        self.navigationController?.navigationBar.tintColor = tintColor
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: makeStackView(rightItems, spacing))
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: makeStackView(leftItems, spacing))
        
    }
}

extension UIViewController {
    @frozen
    enum PageType: String, CaseIterable {
        case home = "홈"
        case realTime = "ㅁ실시간"
        case tvProgram = "TV프로그램"
        case movie = "영화"
        case prarmount = "파라마운트+"
        case kid = "키즈"
        
        var viewController: UIViewController {
            switch self {
            case .home:
                return HomeViewController()
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
}
