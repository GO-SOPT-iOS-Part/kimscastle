//
//  UILabel+.swift
//  TvingCloneCoding
//
//  Created by uiskim on 2023/04/28.
//

import UIKit

extension UILabel {
    /// Image와 String을 하나의 Label로 묶어주는함수
    /// - Parameter composition: NSAttributedString타입의 변수들을 넣으면 되는데, UIImage와 String에 self를 이타입으로 바꿔주는 함수있으니 참고할것
    func labelWithImage(composition: NSAttributedString...) {
        let attributedString = NSMutableAttributedString()
        composition.forEach { attributedString.append($0) }
        self.attributedText = attributedString
    }
}
