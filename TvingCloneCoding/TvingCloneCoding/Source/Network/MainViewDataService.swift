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
    
    let url = "https://api.themoviedb.org/3/movie/popular?api_key=1862a0edf74034806700802061bd0ce4&language=ko-KR"
    
    func fetchMovie(completion: @escaping([ListSection])->Void) {
        AF.request(url, method: .get)
            .validate(statusCode: 200..<300)
            .responseData { datas in
                guard let value = datas.value else {fatalError()}
                let data = try! JSONDecoder().decode(MovieData.self, from: value)
                let myMovieList = data.results.map { movieData in
                    VideoInfo(name: movieData.title, image: movieData.posterPath)
                }
                let mainPoster: ListSection = .mainPoster([.init(name: "", image: nil)])
                let mustWatchList: ListSection = .mustWatchList(myMovieList)
                let quickVODList: ListSection = .quickVODList(myMovieList)
                let watchingList: ListSection = .watchingList(myMovieList)
                let rankingList: ListSection = .rankingList(myMovieList)
                let famousLiveChannel: ListSection = .rankingList(myMovieList)
                
                completion([mainPoster, mustWatchList, quickVODList, watchingList, rankingList, famousLiveChannel])
            }
    }
}
