//
//  CurrentWeather.swift
//  Good Weather
//
//  Created by TheGIZzz on 19/9/2565 BE.
//

import Foundation

struct CurrentWeather: Codable {
    let name : String
    let main : Main
    let weather : [Weather]
    let sys : System
}

struct Main: Codable {
    let temp : Double
    let humidity : Double
}

struct Weather: Codable {
    let description : String
    let icon : String
    let id : Int
}

struct System: Codable {
    let country: String
}
