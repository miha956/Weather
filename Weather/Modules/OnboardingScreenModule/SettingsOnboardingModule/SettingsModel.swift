//
//  SettingsModel.swift
//  Weather
//
//  Created by Миша Вашкевич on 04.04.2024.
//

import Foundation

enum SettingsTitles: String, CaseIterable {
    case temprature = "Температура"
    case windSpeed = "Скорость ветра"
    case timeFormat = "Формат времени"
    case notifications = "Уведомления"

}



struct SettingsModel {
    
    let settingsTitle = "Настройки"
    let optionsTitles = SettingsTitles.allCases
    let options: [[String]] = [["C","F"],["Mi","Km"],["12","24"],["On","Off"]]
    let buttonTitle = "Установить"
    

}
