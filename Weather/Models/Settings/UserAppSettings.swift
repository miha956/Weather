//
//  UserSettings.swift
//  Weather
//
//  Created by Миша Вашкевич on 05.04.2024.
//

import Foundation

struct UserAppSettings: Codable {
    
    var temperature: Temperature = .celcius
    var windSpeed: WindSpeed = .metersPerSecond
    var timeFormat: TimeFormat = .twentyFourHour
    var notificationsIsEnabled: NotificationsState = .off

}

enum Temperature: Int, CaseIterable, Codable {
    case celcius
    case fahrenheit
    
    var value: String {
        switch self {
        case .celcius:
            return "C"
        case .fahrenheit:
            return "F"
        }
    }
    var unit: String {
        switch self {
        case .celcius:
            return "celsius"
        case .fahrenheit:
            return "fahrenheit"
        }
    }
}


enum WindSpeed: Int, CaseIterable, Codable {
    
    case metersPerSecond
    case kilometersPerHour
    
    var value: String {
        switch self {
        case .metersPerSecond:
            return "Mi"
        case .kilometersPerHour:
            return "Km"
        }
    }
    var unit: String {
        switch self {
        case .metersPerSecond:
            return "ms"
        case .kilometersPerHour:
            return "kmh"
        }
    }
}

enum TimeFormat: Int, CaseIterable, Codable {
    case twelveHour
    case twentyFourHour
    
    var value: String {
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
    
    var value: String {
        switch self {
        case .on:
            return "On"
        case .off:
            return "Of"
        }
    }
}
