//
//  MainViewDataService.swift
//  TvingCloneCoding
//
//  Created by uiskim on 2023/05/03.
//

import UIKit

import Alamofire

struct MainViewDataService {
    
    static let shared = MainViewDataService()
    
    enum APIType: CaseIterable {
        case popular
        case nowPlaying
        case topRated
        case upcoming
        
        var url: String {
            switch self {
            case .popular: return "popular"
            case .nowPlaying: return "now_playing"
            case .topRated: return "top_rated"
            case .upcoming: return "upcoming"
            }
        }
    }
    
    private func makeUrl(_ type: APIType) -> String {
        return "https://api.themoviedb.org/3/movie/\(type.url)?api_key=1862a0edf74034806700802061bd0ce4&language=ko-KR"
    }
    
    func fetchMovie(completion: @escaping([ListSection]) -> Void) {
        var movieData: [ListSection] = []
        movieData.append(.mainPoster([.init(name: "", image: nil)]))
        for type in APIType.allCases {
            AF.request(makeUrl(type), method: .get)
                .validate(statusCode: 200..<300)
                .responseData { datas in
                    guard let value = datas.value else { return }
                    let data = try! JSONDecoder().decode(MovieData.self, from: value)
                    let myMovieList = data.results.map { VideoInfo(name: $0.title, image: $0.posterPath) }
                    switch type {
                    case .popular:
                        movieData.append(.mustWatchList(myMovieList))
                    case .nowPlaying:
                        movieData.append(.quickVODList(myMovieList))
                    case .topRated:
                        movieData.append(.watchingList(myMovieList))
                    case .upcoming:
                        movieData.append(.rankingList(myMovieList))
                        movieData.append(.famousLiveChannel(myMovieList))
                    }
                    completion(movieData)
                }
        }
        
    }
}
