//
//  UIImage+.swift
//  SOPT_Week3
//
//  Created by uiskim on 2023/04/22.
//

import UIKit

extension UIImage {
    static var hypeBoy: UIImage {
        guard let image = UIImage(named: "uzs") else { fatalError("이미지 이름오류") }
        return image
    }
}
