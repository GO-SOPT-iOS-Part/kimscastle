//
//  WeatherDetailViewController.swift
//  SOPT_Week4
//
//  Created by uiskim on 2023/05/06.
//

import UIKit

final class WeatherDetailViewController: UIViewController {
    
    var data: Weathers? {
        didSet {
            guard let data else { return }
            dataBind(from: data)
        }
    }
    
    private let weatherImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        return label
    }()
    
    private let weatherDetailLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .light)
        return label
    }()
    
    private let maxTemperatureLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .light)
        return label
    }()
    
    let minTemperatureLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .light)
        return label
    }()
    
    private let winChillTemperatureView = WeatherSectionView(title: "체감온도")
    private let humidityView = WeatherSectionView(title: "습도")
    private let pascalView = WeatherSectionView(title: "압력")
    private let windSpeedView = WeatherSectionView(title: "바람")
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        [weatherImageView, temperatureLabel, weatherDetailLabel, maxTemperatureLabel, minTemperatureLabel, winChillTemperatureView, humidityView, pascalView, windSpeedView].forEach { view.addSubview($0) }
        
        weatherImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(120)
            make.centerX.equalToSuperview()
            make.size.equalTo(100)
        }
        
        temperatureLabel.snp.makeConstraints { make in
            make.top.equalTo(weatherImageView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }

        weatherDetailLabel.snp.makeConstraints { make in
            make.top.equalTo(temperatureLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }

        maxTemperatureLabel.snp.makeConstraints { make in
            make.top.equalTo(weatherDetailLabel.snp.bottom).offset(20)
            make.trailing.equalTo(view.snp.centerX).offset(-10)
        }

        minTemperatureLabel.snp.makeConstraints { make in
            make.top.equalTo(weatherDetailLabel.snp.bottom).offset(20)
            make.leading.equalTo(view.snp.centerX).offset(10)
        }

        winChillTemperatureView.snp.makeConstraints { make in
            make.top.equalTo(minTemperatureLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().inset(10)
            make.size.equalTo((UIScreen.main.bounds.width-30)/2)
        }

        humidityView.snp.makeConstraints { make in
            make.top.equalTo(minTemperatureLabel.snp.bottom).offset(20)
            make.trailing.equalToSuperview().inset(10)
            make.size.equalTo((UIScreen.main.bounds.width-30)/2)
        }

        pascalView.snp.makeConstraints { make in
            make.top.equalTo(winChillTemperatureView.snp.bottom).offset(10)
            make.leading.equalToSuperview().inset(10)
            make.size.equalTo((UIScreen.main.bounds.width-30)/2)
        }

        windSpeedView.snp.makeConstraints { make in
            make.top.equalTo(winChillTemperatureView.snp.bottom).offset(10)
            make.trailing.equalToSuperview().inset(10)
            make.size.equalTo((UIScreen.main.bounds.width-30)/2)
        }
    }
    
    private func dataBind(from inputData : Weathers) {
        self.title = inputData.name
        weatherImageView.getImageFromURL(inputData.weather[0].icon)
        temperatureLabel.text = inputData.main.temp.description.addSymbol(.temperature)
        weatherDetailLabel.text = inputData.weather[0].description
        maxTemperatureLabel.text = "최대 " + inputData.main.temp_max.description.addSymbol(.temperature)
        minTemperatureLabel.text = "최소 " + inputData.main.temp_min.description.addSymbol(.temperature)
        winChillTemperatureView.data = inputData.main.feels_like.description.addSymbol(.temperature)
        humidityView.data = inputData.main.humidity.description.addSymbol(.humidity)
        pascalView.data = inputData.main.pressure.description.addSymbol(.pressure)
        windSpeedView.data = inputData.wind.speed.description.addSymbol(.windSpeed)
    }
}
