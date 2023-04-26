//
//  Photo+.swift
//  SOPT_Week3
//
//  Created by uiskim on 2023/04/22.
//

import UIKit

extension Photo {
    static func dummy() -> [Photo] {
        var photos: [Photo] = []
        for photo in 1..<12 {
            guard let image = UIImage(named: "photo_\(photo)") else { fatalError("이미지로드에러")}
            photos.append(Photo(image: image,
                                heartTapped: false))
        }
        return photos + photos
    }
}
