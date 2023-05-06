//
//  SignUpService.swift
//  SOPT_Week4
//
//  Created by uiskim on 2023/05/06.
//

import UIKit

import Alamofire

protocol SignUpProtocol {
    
    func signUp(email: String,
                nickname: String,
                password: String,
                completion: @escaping (NetworkResult<Any>) -> Void)
}

final class SignUpService: SignUpProtocol {
    
    static var shared = SignUpService()
    
    func signUp(email: String,
                nickname: String,
                password: String,
                completion: @escaping (NetworkResult<Any>) -> Void) {
        
        let url = Config.baseURL + "/user/signup"
        let header: HTTPHeaders = ["Content-Type" : "application/json"]
        let body: Parameters = [
            "password": password,
            "email": email,
            "nickname": nickname,
        ]

        let dataRequest = AF.request(url,
                                     method: .post,
                                     parameters: body,
                                     encoding: JSONEncoding.default,
                                     headers: header)
        
        dataRequest.responseData { response in
            switch response.result {
            case .success:
                guard let statusCode = response.response?.statusCode else { return }
                guard let value = response.value else { return }
                let networkResult = self.judgeStatus(by: statusCode, value)
                completion(networkResult)
                
            case .failure:
                completion(.networkErr)
            }
        }
    }
    
    private func judgeStatus(by statusCode: Int, _ data: Data) -> NetworkResult<Any> {
        switch statusCode {
        case 201: return isValidData(data: data)
        case 400, 409: return isValidData(data: data)
        case 500: return .serverErr
        default: return .networkErr
        }
    }
    
    private func isValidData(data: Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        
        guard let decodedData = try? decoder.decode(SignUpResponse.self, from: data) else { return .pathErr }
        
        return .success(decodedData as Any)
    }
}
