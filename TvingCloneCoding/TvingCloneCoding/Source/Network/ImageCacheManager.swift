//
//  ImageCacheManager.swift
//  TvingCloneCoding
//
//  Created by uiskim on 2023/05/11.
//

import UIKit

enum ImageNetworkError: Error {
  case `default`
}

class ImageCacheManager {
  static let shared = NSCache<NSString, UIImage>()
  private init() { }
}

extension UIImageView {
    func setImageUrl(_ url: String) {
        DispatchQueue.global(qos: .background).async {
            let imageURL = "https://image.tmdb.org/t/p/original/" + url
            let cachedKey = NSString(string: imageURL)

            if let cachedImage = ImageCacheManager.shared.object(forKey: cachedKey) {
                DispatchQueue.main.async {
                    self.image = cachedImage
                }
                return
            }

            guard let url = URL(string: imageURL) else { return }
            URLSession.shared.dataTask(with: url) { (data, result, error) in
                guard error == nil else {
                    DispatchQueue.main.async { [weak self] in
                        self?.image = UIImage()
                    }
                    return
                }
                DispatchQueue.main.async { [weak self] in
                    if let data = data, let image = UIImage(data: data) {
                        ImageCacheManager.shared.setObject(image, forKey: cachedKey)
                        self?.image = image
                    }
                }
            }.resume()
        }
    }
}
