//
//  WeatherViewController.swift
//  SOPT_Week4
//
//  Created by uiskim on 2023/05/06.
//

import UIKit

import SnapKit

final class WeatherViewController: UIViewController {
    
    var weatherDatas: [Weathers] = []
    var weatherTableView = UITableView()
    private let placeNames = ["gongju", "gwangju", "gumi", "gunsan", "daegu", "daejeon", "mokpo", "busan", "seosan", "seoul", "sokcho", "suwon", "suncheon", "ulsan", "iksan", "jeonju", "jeju", "cheonan", "cheongju", "chuncheon"]
    
    lazy var activityIndicator: UIActivityIndicatorView = {
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
        fetchData(placeNames: placeNames, dataType: Weathers.self) { datas in
            self.weatherDatas = datas
            self.weatherTableView.reloadData()
        }

    }
    
    private func fetchData<T: Codable>(placeNames: [String], dataType: T.Type, completionHandler: @escaping([T]) -> Void) {
        
        var datas: [T] = []
        self.activityIndicator.startAnimating()
        placeNames.forEach { WeatherService.shared.findWeatherInfo(place: $0, returnType: T.self) { response in
            switch response {
            case .success(let data):
                datas.append(data)
                
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
