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
    
    /// api key를 가지고 지역이름변수를 넣어서 정보를 가지고 오는 url을 반환해주는 함수
    /// - Parameter place: 지역이름(과제에서 지역이름 list에서 받아온 값을 넣음)
    /// - Returns: api url반환
    private func makeUrl(place: String) -> String {
        return "https://api.openweathermap.org/data/2.5/weather?q=\(place)&appid=fdc8259dd6d036048bdc08673eec9827"
    }
    
    
    /// api를 호출해서 NetworkResult의 타입을 반환해주는 함수(T의 의미 : Codable 프로토콜을 채택하는 어떤타입이라도 올 수 있음)
    /// - Parameters:
    ///   - place: 지역이름
    ///   - returnType: NetworkResult enum Type인데  Success타입인경우 연관값으로 T타입을 가지고있음(타입의 타입을 input으로받아야하기 때문에 `메타타입` 을 사용했음)
    ///   - completion: 연관값 T를 가지고있는 NetworkResult enum Type를 input으로 넣은 escaping 클로저(api를 호출하고 결과를 얻은 후에 호출되는 클로저)
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
    
    /// status코드와 data를 가지고   NetworkResult를 반환해주는 함수, 이때 반환시 내가 원하는 데이터형식으로 변경해줘야한다(T라는 연관값을 가지고 있기 때문에)
    /// - Parameters:
    ///   - statusCode: 말그대로 status code
    ///   - data: Data 타입의 data 우리는 이걸 jsondecoder를 통해 우리가 원하는 swift 구조체로 변경해줘야한다
    ///   - changeData: 우리가원하는 swift 구조체 타입을 넘겨줘야한다(여기도 타입의 타입을 넘겨줘야하기떄문에 메타타입을 사용했음)
    /// - Returns: 연관값을 가지고있는 enum Case를 반환
    private func judgeStatus<T: Codable>(by statusCode: Int, _ data: Data, changeData: T.Type) -> NetworkResult<T> {
        switch statusCode {
        /// 만약 200~300범위의 status code가 반환된다면 isValidData의 리턴값(NetworkResult)을 리턴(NetworkResult)한다
        /// T.self의 의미 : 우리는 타입자체를 input으로 넣어주고 싶은데 타입자체(Int나 String)를 input으로 넣어줄수없기때문에 타입자체를 value로 만들어주는 키워드가 필요함 .self를 붙이면됨
        case 200..<300: return isValidData(data: data, changeData: T.self)
        case 500..<600: return .serverErr
        default: return .networkErr
        }
    }
    
    /// Data타입의 data를 가지고 내가 원하는 구조체 형식으로 decode해서 success case의 연관값으로 넣은 후 success case를 리턴해주는 함수(성공케이스)
    /// - Parameters:
    ///   - data: Data 타입의 data 우리는 이걸 jsondecoder를 통해 우리가 원하는 swift 구조체로 변경해줘야한다
    ///   - changeData: 우리가원하는 swift 구조체 타입을 넘겨줘야한다(여기도 타입의 타입을 넘겨줘야하기떄문에 메타타입을 사용했음)
    /// - Returns: 성공케이스의 연관값을 가지고있는 enum Case를 반환
    private func isValidData<T: Codable>(data: Data, changeData: T.Type) -> NetworkResult<T> {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(T.self, from: data) else { fatalError("decode error") }
        return .success(decodedData)
    }
}

