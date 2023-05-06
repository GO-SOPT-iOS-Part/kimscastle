//
//  SignUpResponse.swift
//  SOPT_Week4
//
//  Created by uiskim on 2023/05/06.
//

import Foundation

struct SignUpResponse: Codable {
    let code: Int
    let success: Bool?
    let message: String
    let data: SignUpData?
}

struct SignUpData: Codable {
    let userId: Int
    let nickname: String
}
