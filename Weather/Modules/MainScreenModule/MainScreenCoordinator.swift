//
//  MainScreenCoordinator.swift
//  Weather
//
//  Created by Миша Вашкевич on 08.04.2024.
//

import Foundation
import UIKit
import CoreData

class MainScreenCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func goToSearchLocationView() {
        
    }
    
    func start() {
        let networkManager = WeatherNetworkManager()
        let coreDataManaager = CoreDataManager()
        let viewModel = LocationsPageViewModel(coreDataManager: coreDataManaager, networkManager: networkManager)
        let viewController = LocationsPageView(viewModel: viewModel)
        navigationController.setViewControllers([viewController], animated: true)
    }
}
