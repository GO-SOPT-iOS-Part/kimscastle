//
//  WeatherTableViewCell.swift
//  SOPT_Week4
//
//  Created by uiskim on 2023/05/06.
//

import UIKit

class WeatherTableViewCell: UITableViewCell, TableViewCellReuseProtocol {
    
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

    private let placeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 25)
        return label
    }()
    
    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 12, weight: .light)
        return label
    }()
    
    private let humidityLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 12, weight: .light)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .white
        [weatherImageView, placeLabel, temperatureLabel, humidityLabel].forEach { addSubview($0) }
        
        weatherImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(10)
            make.centerY.equalToSuperview()
            make.size.equalTo(100)
        }
        
        placeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.trailing.equalToSuperview().inset(10)
        }
        
        temperatureLabel.snp.makeConstraints { make in
            make.top.equalTo(placeLabel.snp.bottom).offset(10)
            make.trailing.equalToSuperview().inset(10)
        }
        humidityLabel.snp.makeConstraints { make in
            make.top.equalTo(temperatureLabel.snp.bottom).offset(10)
            make.trailing.equalToSuperview().inset(10)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func dataBind(from inputData : Weathers) {
        weatherImageView.getImageFromURL(inputData.weather[0].icon)
        placeLabel.text = inputData.name
        temperatureLabel.text = "현재온도 : " + inputData.main.temp.description.addSymbol(.temperature)
        humidityLabel.text = "습도 : " + inputData.main.humidity.description.addSymbol(.humidity)
    }
}
