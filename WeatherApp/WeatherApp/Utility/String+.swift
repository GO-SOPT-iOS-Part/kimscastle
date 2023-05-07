//
//  String+.swift
//  WeatherApp
//
//  Created by uiskim on 2023/05/07.
//

import Foundation

extension String {
    
    enum SymbolType {
        case temperature
        case humidity
        case pressure
        case windSpeed
    }
    
    func addSymbol(_ type: SymbolType) -> Self {
        switch type {
        case .temperature:
            return self + "℃"
        case .humidity:
            return self + "%"
        case .pressure:
            return self + "hpa"
        case .windSpeed:
            return self + "m/s"
        }
    }
}
