//
//  LocationsPageViewModel.swift
//  Weather
//
//  Created by Миша Вашкевич on 15.04.2024.
//

import Foundation
import UIKit

protocol LocationsPageViewModelProtocol {
    
    var views:[UIViewController]  {get}

}

final class LocationsPageViewModel: LocationsPageViewModelProtocol {
    
    // MARK: Properties
    
    private let coreDataManager: CoreDataManagerProtocol
    private let networkManager: WeatherNetworkManagerProtocol
    var views: [UIViewController] = {
        return []
    }()
    
    // MARK: lifeCycle
    
    init(coreDataManager: CoreDataManagerProtocol, networkManager: WeatherNetworkManagerProtocol) {
        self.coreDataManager = coreDataManager
        self.networkManager = networkManager
        fetchLocations()
    }
    
    deinit {
        print("LocationsPageViewModel deinit")
    }
    
    // MARK: Public Methods
    
    func fetchLocations() {
        
        coreDataManager.fetchPlaces { result in
            switch result {
            case .success(let places):
                for place in places {
                    let viewModel = LocationWeatherViewModel(weatherNetworkManager: networkManager,
                                                             coreDataManager: coreDataManager,
                                                             currentPlace: place)
                    let viewController = LocationWeatherView(viewModel: viewModel)
                    views.append(viewController)
                }
            case .failure(let error):
                print("\(error)")
            }
        }
    }
}
