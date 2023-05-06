//
//  Array+.swift
//  TvingCloneCoding
//
//  Created by uiskim on 2023/05/04.
//

import Foundation

extension Array {
    mutating func makeInfinityCarouselArray() {
        self.insert(self[self.count-1], at: 0)
        self.append(self[1])
    }
}
