//
//  WeatherViewController.swift
//  SOPT_Week4
//
//  Created by uiskim on 2023/05/06.
//

import UIKit

import SnapKit

final class WeatherViewController: UIViewController {
    
    private var weatherDatas: [Weathers] = []
    private var weatherTableView = UITableView()
    private let placeNames = ["gongju", "gwangju", "gumi", "gunsan", "daegu", "daejeon", "mokpo", "busan", "seosan", "seoul", "sokcho", "suwon", "suncheon", "ulsan", "iksan", "jeonju", "jeju", "cheonan", "cheongju", "chuncheon"]
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        activityIndicator.center = self.view.center
        activityIndicator.color = .purple
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .medium
        activityIndicator.stopAnimating()
        return activityIndicator
        
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        weatherTableView.dataSource = self
        weatherTableView.delegate = self
        WeatherTableViewCell.register(tableView: weatherTableView)
    }
    
    private func setUI() {
        title = "날씨"
        view.backgroundColor = .white
        view.addSubview(weatherTableView)
        view.addSubview(activityIndicator)
        weatherTableView.rowHeight = 100
        weatherTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        /// placeNames라는 string이 담긴 list를 넣어서 Weathers라는 타입으로 변환해주고 변환이끝나면(조건 : list의 갯수가 같아지면) 그 data를 가지고 특정 클로저(함수)를 실행함
        fetchWeatherData(placeNames, to: Weathers.self) { datas in
            /// 우선 데이터를 받아온 후 그 데이터를 외부변수에 저장하고
            self.weatherDatas = datas
            /// 그 데이터를 가지고 tableView를 새로 그려줘
            self.weatherTableView.reloadData()
        }

    }
}

extension WeatherViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherDatas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = WeatherTableViewCell.dequeueReusableCell(tableView: tableView)
        cell.data = weatherDatas[indexPath.row]
        return cell
    }
}

extension WeatherViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailViewController = WeatherDetailViewController()
        detailViewController.data = weatherDatas[indexPath.row]
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
}

private extension WeatherViewController {
    
    /// 날씨정보를 가져와서 escaping 클로저(네트워킹이 끝난 후 호출되는함수)의 input으로 넣어주는 함수
    /// - Parameters:
    ///   - placeNames: 날씨정보를 원하는 지역이름이 string타입으로 담긴 list
    ///   - dataType: 각각의 날씨정보(DataType)을 내가 원하는 데이터타입으로 바꾸고 싶을때 어떤 데이터타입으로 바꾸고싶은지(타입자체를 input으로 받을것이기때문에 메타타입사용)
    ///   - completionHandler: 데이터를 받아왔을때 호출될 클로저(클로저의 input은 변환된 데이터의 인스턴스)
    func fetchWeatherData<T: Codable>(_ placeNames: [String], to dataType: T.Type, completionHandler: @escaping([T]) -> Void) {
        var datas: [T] = []
        self.activityIndicator.startAnimating()
        /// T.self와 T의 차이 : T는 내가 타입의 인스턴스를 받고싶을때 사용, T.sefl는 타입자체를 받고싶을때 사용
        /// 예를 들어서(Int는 타입이고 1,2,3은 Int타입의 인스턴스임) Int타입으로 변환시키고 싶다면 타입자체를 받아야하기때문에 T.self를 사용해야하고 1,2,3을 받아서 다른 무언가로 변환시키고싶다면 타입의 인스턴스를 받아야하기때문에 T라고 사용할수있음
        placeNames.forEach { WeatherService.shared.findWeatherInfo(place: $0, returnType: T.self) { response in
            switch response {
            /// 연관값을 가지고있는 enum Case는 연관값을 `바인딩`을 활용하여 데이터를 꺼내쓸수있음(let data부분)
            case .success(let data):
                datas.append(data)
                /// completionHandler의 뜻자체가 무슨 task가 끝났을때 호출될 함수라는의미인데
                /// 현재는 저 지역이름들이 담긴 리스트의 데이터를 모두 불러왔을때 호출되야함 == 즉, 지금 현재 datas라는 빈리스트에 갯수와 지역이름이 담긴 list의 갯수가 동일해야 그때서야 completionHandler를 호출해야하기때문에 forEach를 사용해서 조건을 만족했을때 completionHandler를 실행할수있도록 구현
                if datas.count == placeNames.count {
                    self.activityIndicator.stopAnimating()
                    completionHandler(datas)
                }
            case .serverErr:
                fatalError("서버에러")
            case .networkErr:
                fatalError("네트워크에러")
            }
        }}
    }
}
