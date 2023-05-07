//
//  WeatherService.swift
//  SOPT_Week4
//
//  Created by uiskim on 2023/05/06.
//

import Foundation

import Alamofire

final class WeatherService {
    
    static var shared = WeatherService()
    
    private func makeUrl(place: String) -> String {
        return "https://api.openweathermap.org/data/2.5/weather?q=\(place)&appid=fdc8259dd6d036048bdc08673eec9827"
    }
    
    func findWeatherInfo<T: Codable>(place: String, returnType: T.Type, completion: @escaping (NetworkResult<T>) -> Void) {
        let header: HTTPHeaders = ["Content-Type" : "application/json"]
        let dataRequest = AF.request(makeUrl(place: place),
                                     method: .get,
                                     parameters: nil,
                                     headers: header)
        
        dataRequest.responseData { response in
            switch response.result {
            case .success:
                guard let statusCode = response.response?.statusCode else { return }
                guard let value = response.value else { return }
                let networkResult = self.judgeStatus(by: statusCode, value, changeData: T.self)
                completion(networkResult)
            case .failure:
                completion(.networkErr)
            }
        }
    }
    
    private func judgeStatus<T: Codable>(by statusCode: Int, _ data: Data, changeData: T.Type) -> NetworkResult<T> {
        switch statusCode {
        case 200..<300: return isValidData(data: data, changeData: T.self)
        case 500..<600: return .serverErr
        default: return .networkErr
        }
    }
    
    private func isValidData<T: Codable>(data: Data, changeData: T.Type) -> NetworkResult<T> {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(T.self, from: data) else { fatalError("decode error") }
        return .success(decodedData)
    }
}

