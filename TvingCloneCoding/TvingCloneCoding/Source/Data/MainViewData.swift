//
//  MainViewData.swift
//  TvingCloneCoding
//
//  Created by uiskim on 2023/05/03.
//

import UIKit

struct MainViewData {
    static let shared = MainViewData()
    
    private let mustWatchList: ListSection = .mustWatchList([
        .init(name: "더 디저트", image: .assetImage(.poster1)),
        .init(name: "더 타임호텔", image: .assetImage(.poster2)),
        .init(name: "부산촌놈 in 시드니", image: .assetImage(.poster3)),
        .init(name: "청춘 MT", image: .assetImage(.poster4))
    ])
     
    private let quickVODList: ListSection = .quickVODList([
        .init(name: "더 디저트", image: .assetImage(.poster1)),
        .init(name: "더 타임호텔", image: .assetImage(.poster2)),
        .init(name: "부산촌놈 in 시드니", image: .assetImage(.poster3)),
        .init(name: "청춘 MT", image: .assetImage(.poster4))
    ])
    
    private let watchingList: ListSection = .watchingList([
        .init(name: "더 디저트", image: .assetImage(.poster1)),
        .init(name: "더 타임호텔", image: .assetImage(.poster2)),
        .init(name: "부산촌놈 in 시드니", image: .assetImage(.poster3)),
        .init(name: "청춘 MT", image: .assetImage(.poster4))
    ])
    
    private let rankingList: ListSection = .rankingList([
        .init(name: "더 디저트", image: .assetImage(.poster1)),
        .init(name: "더 타임호텔", image: .assetImage(.poster2)),
        .init(name: "부산촌놈 in 시드니", image: .assetImage(.poster3)),
        .init(name: "청춘 MT", image: .assetImage(.poster4))
    ])
     
    
    private let famousLiveChannel: ListSection = .famousLiveChannel([
        .init(name: "더 디저트", image: .assetImage(.poster1)),
        .init(name: "더 타임호텔", image: .assetImage(.poster2)),
        .init(name: "부산촌놈 in 시드니", image: .assetImage(.poster3)),
        .init(name: "청춘 MT", image: .assetImage(.poster4))
    ])
    
    var pageData: [ListSection] {
        return [mustWatchList, quickVODList, watchingList, rankingList, famousLiveChannel]
    }
}
