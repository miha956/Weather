//
//  CoordinarProtocol.swift
//  Weather
//
//  Created by Миша Вашкевич on 02.04.2024.
//

import UIKit

protocol CoordinatorProtocol {
    
    var childcoordinator: [CoordinatorProtocol] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
}
