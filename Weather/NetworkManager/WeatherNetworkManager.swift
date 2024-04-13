//
//  WeatherNetworkManager.swift
//  Weather
//
//  Created by Миша Вашкевич on 09.04.2024.
//

import Foundation
import CoreLocation


protocol WeatherNetworkManagerProtocol {
    
    func fetchCurrentWeatherData(latitude: String, longitude: String, complition: @escaping(Result<WeatherTodayModel, Error>) -> Void)
    func fetchDailyWeatherData(latitude: String, longitude: String, complition: @escaping(Result<WeatherDailyModel, Error>) -> Void)
}

final class WeatherNetworkManager: WeatherNetworkManagerProtocol {
    
    private enum ApiURL {
        case forcast
        case geocoding
        
        var baseURL: String {
            switch self {
            case .forcast:
                return "https://api.open-meteo.com/v1/forecast?"
            case .geocoding:
                return "https://geocoding-api.open-meteo.com/v1/search?"
            }
        }
    }
    
    enum Endpoint {
        case currentWeather
        case dailyWeather
        case deocoding
        
        fileprivate var requestParameters: String {
            switch self {
            case .currentWeather:
                return "current=temperature_2m,relative_humidity_2m,apparent_temperature,is_day,precipitation,weather_code,cloud_cover,surface_pressure&hourly=temperature_2m,relative_humidity_2m,apparent_temperature,precipitation_probability,weather_code,surface_pressure,cloud_cover&temperature_unit=fahrenheit&wind_speed_unit=mph&timezone=Europe%2FMoscow&forecast_days=2"
            case .dailyWeather:
                return "daily=weather_code,temperature_2m_max,temperature_2m_min,sunrise,sunset,daylight_duration,sunshine_duration,precipitation_sum,precipitation_probability_max&temperature_unit=fahrenheit&wind_speed_unit=mph&timezone=Europe%2FMoscow&forecast_days=10"
            case .deocoding:
                return "count=10&format=json"
            }
        }
        fileprivate var url: String {
            switch self {
            case .currentWeather:
                return "\(ApiURL.forcast.baseURL)\(requestParameters)"
            case .dailyWeather:
                return "\(ApiURL.forcast.baseURL)\(requestParameters)"
            case .deocoding:
                return "\(ApiURL.geocoding.baseURL)\(requestParameters)"
            }
        }
    }
    
//    let windSpeedUnit: WindSpeed
//    let temperatureUnit: Temperature
//    let timeZone = ""
//    let nubmerOfdays = ""
    // language
    
    
    private func requestData(urlString: String, completion: @escaping(Result<Data, Error>) -> Void) {
        
        guard let url = URL(string: urlString) else {
            completion(.failure(NetworkMangerError.noConnection))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                    completion(.failure(error))
            }
            guard let data = data else { return }
                completion(.success(data))
        }
        .resume()
    }
    
    private func decodeData<T: Decodable>(urlString : String, response: @escaping(T?, Error?) -> Void) {

          self.requestData(urlString: urlString) { result in
            switch result {
              case .success(let data):
                  do {
                    let data = try JSONDecoder().decode(T.self, from: data)
                    response(data, nil)
                  } catch let jsonError {
                    print("Некорретный ответ", jsonError)
                  }
              case .failure(let error):
                  print("Ошибка получения данных \(error.localizedDescription)")
                  response(nil, error)
              }
          }
      }
    
    func fetchCurrentWeatherData(latitude: String, longitude: String, complition: @escaping(Result<WeatherTodayModel, Error>) -> Void) {
        
        let url = "\(Endpoint.currentWeather.url)&latitude=\(latitude)&longitude=\(longitude)"
        decodeData(urlString: url) { (data: WeatherTodayModel?, error) in
            if let error = error {
                complition(.failure(error))
            } else {
                guard let data = data else { return }
                complition(.success(data))
            }
        }
    }
    
    func fetchDailyWeatherData(latitude: String, longitude: String, complition: @escaping(Result<WeatherDailyModel, Error>) -> Void) {
        
        let url = "\(Endpoint.dailyWeather.url)&latitude=\(latitude)&longitude=\(longitude)"
        
        decodeData(urlString: url) { (data: WeatherDailyModel?, error) in
            if let error = error {
                complition(.failure(error))
            } else {
                guard let data = data else {
                    complition(.failure(NetworkMangerError.noData))
                    return
                }
                complition(.success(data))
            }
        }
    }
    
    func fetchLocationGeocoding(name: String, complition: @escaping(Result<GeocodingLocationsModel, Error>) -> Void) {
        let url = "\(Endpoint.deocoding.url)&name=\(name)"
        print(url)
        decodeData(urlString: url) { (data: GeocodingLocationsModel?, error) in
            if let error = error {
                complition(.failure(error))
            } else {
                guard let data = data else {
                    complition(.failure(NetworkMangerError.noData))
                    return
                }
                complition(.success(data))
            }
        }
    }
}
