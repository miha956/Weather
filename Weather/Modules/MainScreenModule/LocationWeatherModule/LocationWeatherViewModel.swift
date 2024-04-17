//
//  CityWeatherViewModel.swift
//  Weather
//
//  Created by Миша Вашкевич on 06.04.2024.
//

import Foundation
import UIKit

enum LocationWeatherViewState {
    case initial
    case loading
    case success
    case error(Error?)
}


protocol LocationWeatherViewModelProtocol {
    
    var numbersOfHoursCell: Int { get }
    var numbersOfDaysCell: Int { get }
    var dataFetchState: ((LocationWeatherViewState) -> Void)? { get set }
    
    func fetchWeatherData()
    func getCurrentViewInfo() -> (locationName: String, temperature: String, weatherDescription: String, tempMax: String, tempMin: String)
    func getHourlyWeatherInfo(for indexPath: IndexPath) -> (hour: String, weatherImage: UIImage, temperature: String, precipitationProbability: String?)
    func getDailyWeatherInfo(for indexPath: IndexPath) -> (date: String, weatherImage: UIImage, precipitationProbability: String?, minTemp: String, maxTemp: String)
}


final class LocationWeatherViewModel: LocationWeatherViewModelProtocol {
    
    // MARK: Properties
    
    private let weatherNetworkManager: WeatherNetworkManagerProtocol
    private let coreDataManager: CoreDataManagerProtocol
    private var currentPlace: Place
    private var weatherData: WeatherModel!
    private var currentHour: Int {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH"
        dateFormatter.locale = .current
        guard let hour = Int(dateFormatter.string(from: date)) else {return 0}
        return hour
    }
    
    
    var numbersOfHoursCell: Int {
        guard weatherData != nil else {return 0}
        return 24
    }
    var numbersOfDaysCell: Int {
        guard weatherData != nil else {return 0}
        return 10
    }
    var dataFetchState: ((LocationWeatherViewState) -> Void)?
    private var state: LocationWeatherViewState = .initial {
        didSet {
            dataFetchState?(state)
        }
    }
    
    // MARK: lifeCycle
    
    init(weatherNetworkManager: WeatherNetworkManagerProtocol, coreDataManager: CoreDataManagerProtocol, currentPlace: Place) {
        self.weatherNetworkManager = weatherNetworkManager
        self.coreDataManager = coreDataManager
        self.currentPlace = currentPlace
    }
    
    deinit {
        print("LocationWeatherViewModel deinit")
    }
    
    // MARK: Public
    
    func fetchWeatherData() {
        
        state = .loading
        
        guard let latitude = currentPlace.latitude, let longitude = currentPlace.longitude else {
            dataFetchState?(.error(nil))
            return
        }
        
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        weatherNetworkManager.fetchWeatherData(latitude: latitude,
                                                      longitude: longitude) { [weak self] result in
            guard let self = self else {return}
            
            switch result {
            case .success(let weatherData):
                self.weatherData = weatherData
            case .failure(let error):
                state = .error(error)
                return
            }
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main) { [weak self] in
            guard let self = self else {return}
            
            state = .success
            
            guard let locationId = self.currentPlace.id else {return}
            self.coreDataManager.updateWeatherData(locationId: locationId, weather: weatherData)
        }
    }
    
    func getCurrentViewInfo() -> (locationName: String, temperature: String, weatherDescription: String, tempMax: String, tempMin: String) {
                
        let locationName = currentPlace.name!
        let temperature = "\(weatherData.current.temperature.toInt)"
        let weatherDescription = weatherData.current.weatherCode.weatherCodeDescription
        let tempMax = "\(weatherData.daily.temperatureMax.first!.toInt)"
        let tempMin = "\(weatherData.daily.temperatureMin.first!.toInt)"
        
        return (locationName: locationName, temperature: temperature, weatherDescription: weatherDescription, tempMax: tempMax, tempMin: tempMin)
    }
    
    func getHourlyWeatherInfo(for indexPath: IndexPath) -> (hour: String, weatherImage: UIImage, temperature: String, precipitationProbability: String?) {
    
        let index = indexPath.row + currentHour
        let hour = weatherData.hourly.time[index].getHourFromDate
        //let weatherImage = UIImage(named: "weatherCode-\(currentWeather.hourly.weatherCode[indexPath.row])")
        let weatherImage = UIImage(named: "weatherCode-0")!
        let temp = "\(weatherData.hourly.temperature[index].toInt)"
        var precipitationProbability: String? {
            guard let probability = weatherData.hourly.precipitationProbability[index] else {
                return nil
            }
            return probability < 10 ? nil : "\(probability)"
        }
        return (hour: hour, weatherImage: weatherImage, temperature: temp, precipitationProbability: precipitationProbability)
    }
    
    func getDailyWeatherInfo(for indexPath: IndexPath) -> (date: String, weatherImage: UIImage, precipitationProbability: String?, minTemp: String, maxTemp: String) {
        
        let date = weatherData.daily.time[indexPath.row].getWeekdayFromDate
        //let weatherImage = UIImage(named: "weatherCode-\(dailyWeather.daily.weatherCode[indexPath.row])")!
        let weatherImage = UIImage(named: "weatherCode-0")!
        var precipitationProbability: String? {
            guard let probability = weatherData.daily.precipitationProbabilityMax[indexPath.row] else {
                return nil
            }
            return probability < 10 ? nil : "\(probability)"
        }
        let minTemp = "\(weatherData.daily.temperatureMin[indexPath.row].toInt)"
        let maxTemp = "\(weatherData.daily.temperatureMax[indexPath.row].toInt)"
        
        return (date: date, weatherImage: weatherImage, precipitationProbability: precipitationProbability, minTemp: minTemp, maxTemp: maxTemp)
    }
}
