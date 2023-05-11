//
//  MovieData.swift
//  TvingCloneCoding
//
//  Created by uiskim on 2023/05/11.
//

import Foundation

struct MovieData: Codable {
    let results: [Result]
    
    enum CodingKeys: String, CodingKey {
        case results
    }

    struct Result: Codable {
        let posterPath, releaseDate, title: String

        enum CodingKeys: String, CodingKey {
            case posterPath = "poster_path"
            case releaseDate = "release_date"
            case title
        }
    }
}
