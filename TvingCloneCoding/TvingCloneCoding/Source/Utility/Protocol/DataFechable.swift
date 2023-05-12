//
//  DataFechable.swift
//  TvingCloneCoding
//
//  Created by uiskim on 2023/05/12.
//

import Foundation

protocol DataFechable {
    func fetchMovie(completion: @escaping([ListSection]) -> Void)
}
