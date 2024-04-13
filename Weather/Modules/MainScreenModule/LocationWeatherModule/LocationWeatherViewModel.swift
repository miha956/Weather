//
//  CityWeatherViewModel.swift
//  Weather
//
//  Created by Миша Вашкевич on 06.04.2024.
//

import Foundation

enum LocationWeatherViewState {
    case idle
    case loading
    case success(Place)
    case error(Error)
}


protocol LocationWeatherViewModelProtocol {
    
    var dataFetchState: ((LocationWeatherViewState) -> Void)? { get set }
    func fetchWeatherData(latitude: String, longitude: String)
}


final class LocationWeatherViewModel: LocationWeatherViewModelProtocol {
    
    let weatherNetworkManager: WeatherNetworkManagerProtocol
    
    var dataFetchState: ((LocationWeatherViewState) -> Void)?
    
    init(weatherNetworkManager: WeatherNetworkManagerProtocol) {
        self.weatherNetworkManager = weatherNetworkManager
    }
    
    
    
    func fetchWeatherData(latitude: String, longitude: String) {
        dataFetchState?(.loading)
        weatherNetworkManager.fetchCurrentWeatherData(latitude: latitude, 
                                                      longitude: longitude)
        { result in
            switch result {
            case .success(let weatherDaata):
                print(weatherDaata)
            case .failure(let error):
                print(error)
            }
        }
        weatherNetworkManager.fetchDailyWeatherData(latitude: latitude, 
                                                    longitude: longitude)
        { result in
            switch result {
            case .success(let weatherDaata):
                print(weatherDaata)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
}
