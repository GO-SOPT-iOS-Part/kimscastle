//
//  ImageCacheManager.swift
//  TvingCloneCoding
//
//  Created by uiskim on 2023/05/11.
//

import UIKit

class ImageCacheManager {
  static let shared = NSCache<NSString, UIImage>()
  private init() { }
}
