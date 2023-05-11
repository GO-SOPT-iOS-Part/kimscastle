//
//  UIImageView+.swift
//  TvingCloneCoding
//
//  Created by uiskim on 2023/05/11.
//

import UIKit

extension UIImageView {
    
    func loadImage(from urlString: String) -> URLSessionDataTask? {
        let imageURL = "https://image.tmdb.org/t/p/original/" + urlString
        guard let url = URL(string: imageURL) else { return nil }
        self.image = nil
        if let cachedImage = ImageCacheManager.shared.object(forKey: urlString as NSString) {
            self.image = cachedImage
            return nil
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil { return }
            guard let data = data else { return }
            DispatchQueue.main.async {
                guard let img = UIImage(data: data) else { return }
                ImageCacheManager.shared.setObject(img, forKey: urlString as NSString)
                self.image = img
            }
        }
        task.resume()
        return task
    }
}
