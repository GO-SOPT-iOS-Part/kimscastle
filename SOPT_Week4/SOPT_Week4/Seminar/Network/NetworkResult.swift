//
//  NetworkResult.swift
//  SOPT_Week4
//
//  Created by uiskim on 2023/05/06.
//

import Foundation

enum NetworkResult<T> {
    case success(T)     // 서버 통신 성공
    case serverErr  // 서버 내부 에러
    case networkErr // 네트워크 연결 실패
}
