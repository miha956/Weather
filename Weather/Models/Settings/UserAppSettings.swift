//
//  UserSettings.swift
//  Weather
//
//  Created by Миша Вашкевич on 05.04.2024.
//

import Foundation

struct UserAppSettings: Codable {
    
    var temperature: Int = Temperature.celcius.rawValue
    var windSpeed: Int = WindSpeed.metersPerSecond.rawValue
    var timeFormat: Int = TimeFormat.twentyFourHour.rawValue
    var notificationsIsEnabled: Int = NotificationsState.off.rawValue
    
    lazy var settingsArray: [Int] = [temperature,windSpeed,timeFormat,notificationsIsEnabled]
    
}

enum Temperature: Int, CaseIterable, Codable {
    case celcius
    case farenheit
    
    var name: String {
        switch self {
        case .celcius:
            return "C"
        case .farenheit:
            return "F"
        }
    }
}

enum WindSpeed: Int, CaseIterable, Codable {
    case metersPerSecond
    case kilometersPerHour
    
    var name: String {
        switch self {
        case .metersPerSecond:
            return "Mi"
        case .kilometersPerHour:
            return "Km"
        }
    }
}

enum TimeFormat: Int, CaseIterable, Codable {
    case twelveHour
    case twentyFourHour
    
    var name: String {
        switch self {
        case .twelveHour:
            return "12"
        case .twentyFourHour:
            return "24"
        }
    }
}

enum NotificationsState: Int, CaseIterable, Codable {
    case on
    case off
    
    var value: Bool {
        switch self {
        case .on:
            return true
        case .off:
            return false
        }
    }
}
