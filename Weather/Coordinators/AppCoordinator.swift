//
//  Appoordinator.swift
//  Weather
//
//  Created by Миша Вашкевич on 08.04.2024.
//

import UIKit

class AppCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    
    var window: UIWindow
    
    var navigationController: UINavigationController = {
        let navigationController = UINavigationController()
        // set appereance navigationController
        return navigationController
    }()
    
    init(window: UIWindow) {
        self.window = window
        self.window.rootViewController = navigationController
        self.window.makeKeyAndVisible()
    }
    
    deinit {
        print("deinit AppCoordinator")
    }
    
    func start() {
        let onboardingCoordinator = OnboardingCoordinator(navigationController: navigationController)
        onboardingCoordinator.start()
    }
}
