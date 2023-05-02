//
//  UIImage+.swift
//  TvingCloneCoding
//
//  Created by uiskim on 2023/04/13.
//

import UIKit

extension UIImage {    
    static var setNavigationBackButtonImage: UIImage? {
        return UIImage(named: Constant.ImageName.backButton)
    }
}

extension UIImage {
    
    /// Label안에 Image를 넣을때 적절한 image타입으로 만들어주는 함수
    /// - Returns: NSAttributedString
    func makeSubscriptionAttachImage() -> NSAttributedString {
        let container = NSTextAttachment()
        container.image = self
        return NSAttributedString(attachment: container)
    }
}
