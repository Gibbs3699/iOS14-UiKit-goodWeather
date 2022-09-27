//
//  APICaller.swift
//  Good Weather
//
//  Created by TheGIZzz on 19/9/2565 BE.
//

import Foundation

class APICaller {
    
    public static let share = APICaller()
    
    private struct Constants {
        static let apiKey: String =  "f8788d0330fcd61f7b655c9709c833bd"
        static let baseUrl: String = "https://api.openweathermap.org"
        static func getCurrentLocationWeather(latitude: String, longtitude: String) -> String {
            return "\(baseUrl)/data/2.5/weather?appid=\(apiKey)&units=metric&lat=\(latitude)&lon=\(longtitude)"
        }
    }
    
// MARK: - Public
    public func getCurrentLocationWeather(lat: String, lon: String , completion: @escaping (Result<CurrentWeather, Error>) -> Void) {
        
        guard let url = URL(string: Constants.getCurrentLocationWeather(latitude: lat, longtitude: lon)) else { return }
        print("getCurrentLocationWeather url: \(url)")
        request(url: url, expecting: CurrentWeather.self, completion: completion)
    }
    
// MARK: - Private
    
    private enum APIError: Error {
        case noDataReturned
        case invalidUrl
    }
    
    private func request<T: Codable>(
        url: URL?,
        expecting: T.Type,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        guard let url = url else {
            // Invalid url
            completion(.failure(APIError.invalidUrl))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.failure(APIError.noDataReturned))
                }
                return
            }

            do {
                let result = try JSONDecoder().decode(expecting, from: data)
                completion(.success(result))
            }
            catch {
                completion(.failure(error))
            }
        }

        task.resume()
    }
}
