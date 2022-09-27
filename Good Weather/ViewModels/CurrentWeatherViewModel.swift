//
//  CurrentWeatherViewModel.swift
//  Good Weather
//
//  Created by TheGIZzz on 19/9/2565 BE.
//

import Foundation

struct CurrentWeatherViewModel {
    
    let conditionId: Int
    let cityName: String
    let temperature: Double
    let humidity: Double
    let conditionDescription: String
    let country: String

    var temperatureString : String {
        let tempRounded = String(format: "%.1f", temperature)
        
        if UserDefaults.standard.value(forKey: "unit") as! String == "metric" {
            return "\(tempRounded) °C"
        } else {
            return "\(tempRounded) °F"
        }
    }
    
    var humidityString : String {
        let humidity = String(format: "%.1f", humidity)
        
        return "\(humidity) °"
    }

    var conditionName: String {
        switch conditionId {
        case 200...232:
            return "thunderstorm"
        case 300...321:
            return "dizzle"
        case 500...531:
            return "rain"
        case 600...622:
            return "snow"
        case 701...781:
            return "atmosphere"
        case 800:
            return "clear"
        case 801...804:
            return "clounds"
        default:
            return "clounds"
        }
    }
}

