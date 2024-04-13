//
//  CoreDataManager.swift
//  Weather
//
//  Created by Миша Вашкевич on 05.04.2024.
//

import Foundation
import CoreData

protocol CoreDataManagerProtocol {
    
}

final class CoreDataManager: CoreDataManagerProtocol {
    
    
    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Weather")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func saveLocation(location: Place, complition: @escaping(Result<String, Error>) -> Void) {
        
        persistentContainer.performBackgroundTask { backgroundContext in
            
            let place = Place(context: backgroundContext)
            place.id = location.id
            place.name = location.name
            place.latitude = location.latitude
            place.longitude = location.longitude
            place.currentWeather = location.currentWeather
            place.dailyWeather = location.dailyWeather
            place.updateDate = Date()
                do {
                    try backgroundContext.save()
                    complition(.success("place saved"))
                } catch {
                    print(error.localizedDescription)
                    complition(.failure(CoreDataManagerError.saveDataError))
                }
            }
    }
    
    func updateWeatherData(locationId: String, currentWeather: WeatherTodayModel, dailyWeather: WeatherDailyModel) {
        persistentContainer.performBackgroundTask { backgroundContext in
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Place")
            fetchRequest.predicate = NSPredicate(format: "id = %@", locationId)
            
            do {
                if let result = try backgroundContext.fetch(fetchRequest) as? [NSManagedObject], let place = result.first {
                    
                    do {
                        let currentWeatherData = try JSONEncoder().encode(currentWeather)
                        place.setValue(currentWeatherData, forKey: "currentWeather")
                        
                        let dailyWeatherData = try JSONEncoder().encode(dailyWeather)
                        place.setValue(dailyWeatherData, forKey: "dailyWeather")
                        
                        try backgroundContext.save()
                        print("Данные успешно обновлены")
                        
                    } catch {
                        // error
                    }
                } else {
                    print("Объект с id \(locationId) не найден")
                }
            } catch {
                print("Ошибка при обновлении данных: \(error.localizedDescription)")
            }
        }
    }
    
    func delelePostFromFvorite(location: Place) {
        
        persistentContainer.performBackgroundTask { backgroundContext in
            let placeForDelete = backgroundContext.object(with: location.objectID)
            backgroundContext.delete(placeForDelete)
            
            do {
                try backgroundContext.save()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func isEnableToSaveLocation(locationId: String, complition: (Result<Bool, Error>) -> Void) {
        
        let fetchRequest: NSFetchRequest<Place> = Place.fetchRequest()
        do {
            let place = try persistentContainer.viewContext.fetch(fetchRequest)
            if place.contains(where: {$0.id == locationId}) {
                complition(.failure(CoreDataManagerError.locationAlreadyExist))
            } else {
                complition(.success(true))
            }
        } catch {
            print(CoreDataManagerError.fetchRequestError)
        }
    }
    
    
}

//func saveContext () {
//        let context = persistentContainer.viewContext
//        if context.hasChanges {
//            do {
//                try context.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nserror = error as NSError
//                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
//            }
//        }
//    }
