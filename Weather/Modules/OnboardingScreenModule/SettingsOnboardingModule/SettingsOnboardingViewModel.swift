//
//  SettingsOnboardingViewModel.swift
//  Weather
//
//  Created by Миша Вашкевич on 04.04.2024.
//

import Foundation
import UIKit

protocol SettingsOnboardingViewModelProtocol {
    
    var content: SettingsModel {get}
    var buttonTitle: String {get}
    var viewTitle: String {get}
    var numberOfItems: Int {get}
    var currentSettings: [Int] {get set}
    
    func loadSettints()
    func segmentValueChanged(tag: Int, value: Int)
    func saveSettings()
    
    
}

final class SettingsOnboardingViewModel: SettingsOnboardingViewModelProtocol {
    
    // MARK: Properties
    
    var userSettingsDataManager: UserSettingsDataManagerProtocol
    var coordinator: OnboardingCoordinator?
    
    // MARK: - DataSource
    
    var numberOfItems: Int {
        return content.optionsTitles.count
    }
    var viewTitle: String {
        return content.settingsTitle
    }
    
    var buttonTitle: String {
        return content.buttonTitle
    }
    
    var content: SettingsModel {
        SettingsModel()
    }
    
    var currentSettings: [Int] = []
    
    init(userSettingsDataManager: UserSettingsDataManagerProtocol) {
        self.userSettingsDataManager = userSettingsDataManager
    }
    
    deinit {
        print("deinit SettingsOnboardingViewModel")
    }
    
    func loadSettints() {

        userSettingsDataManager.loadSettings { result in
            switch result {
            case .success(var loadedSettings):
                currentSettings = loadedSettings.settingsArray
            case .failure(_): break
            }
        }
    }
    
    func segmentValueChanged(tag: Int, value: Int) {
        currentSettings[tag] = value
    }
    
    func saveSettings() {
        var userSettings = UserAppSettings()
        userSettings.temperature = currentSettings[0]
        userSettings.windSpeed = currentSettings[1]
        userSettings.timeFormat = currentSettings[2]
        userSettings.notificationsIsEnabled = currentSettings[3]
        
        userSettingsDataManager.saveSettings(userAppSettings: userSettings)
    }
}



