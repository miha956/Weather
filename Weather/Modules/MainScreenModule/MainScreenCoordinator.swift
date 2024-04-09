//
//  MainScreenCoordinator.swift
//  Weather
//
//  Created by Миша Вашкевич on 08.04.2024.
//

import Foundation
import UIKit

class MainScreenCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = CityWeatherViewModel()
        let viewController = CityWeatherView(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
}
