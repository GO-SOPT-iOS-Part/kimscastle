//
//  UICollectionView+.swift
//  TvingCloneCoding
//
//  Created by uiskim on 2023/05/04.
//

import UIKit

extension UICollectionView {
    func scroll(to item: Int, animation: Bool = false) {
        self.scrollToItem(at: IndexPath(item: item, section: 0), at: .centeredHorizontally, animated: animation)
    }
}

