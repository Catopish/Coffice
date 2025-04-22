//
//  HomepageViewModel.swift
//  Coffice
//
//  Created by Hafi on 21/04/25.
//

import Foundation
import CoreLocation

extension Homepage {
    @Observable
    class ViewModel {
        var coffeeShops: [CoffeeShops] = []
        var streakManager = StreakManager()
        var healthViewModel = HealthDashboardViewModel()
        var locationManager = LocationManager()
        var mapWalkingManager = MapWalkingManager()
        var liveViewModel = LiveActivityViewModel()
        var updatedCoffeeShopsState: [CoffeeShops] = []
        
        init() {
            loadCoffeeShops()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.updateCoffeeShopsWithCalories()
            }
        }
        
        func updateCoffeeShopsWithCalories() {
            guard let userLocation = locationManager.userLocation else { return }
            
            var newCoffeeShops: [CoffeeShops] = []
            let group = DispatchGroup()
            
            // Use the original filtered array (based on search) here.
            for shop in coffeeShops {
                var updatedShop = shop
                let destinationCoordinate = CLLocationCoordinate2D(latitude: shop.latitude, longitude: shop.longitude)
                
                group.enter()
                // Calculate the route asynchronously.
                mapWalkingManager.calculateRoute(from: userLocation.coordinate, to: destinationCoordinate) { success in
                    if success,
                       let travelTime = self.mapWalkingManager.travelTime,
                       let routeDistance = self.mapWalkingManager.distance {
                        updatedShop.distance = routeDistance
                        let estimatedCalories = self.mapWalkingManager.calculateCaloriesBurned(for: routeDistance, at: 4.0, in: travelTime)
                        updatedShop.calories = estimatedCalories
                        let estimatedSteps = self.mapWalkingManager.calculateSteps(for: routeDistance)
                        updatedShop.steps = estimatedSteps
                    } else {
                        // Fallback to geodesic distance.
                        let shopLocation = CLLocation(latitude: shop.latitude, longitude: shop.longitude)
                        updatedShop.distance = userLocation.distance(from: shopLocation)
                    }
                    newCoffeeShops.append(updatedShop)
                    group.leave()
                }
            }
            
            group.notify(queue: .main) {
                self.updatedCoffeeShopsState = newCoffeeShops.sorted { $0.distance < $1.distance }
            }
        }
        
        func loadCoffeeShops() {
            guard let url = Bundle.main.url(forResource: "coffee_shops", withExtension: "json") else {
                print("❌ Could not find coffee_shops.json in bundle")
                return
            }
            
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let decoded = try decoder.decode([CoffeeShops].self, from: data)
                self.coffeeShops = decoded
            }  catch let DecodingError.dataCorrupted(context) {
                print(context)
            } catch let DecodingError.keyNotFound(key, context) {
                print("Key '\(key)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch let DecodingError.valueNotFound(value, context) {
                print("Value '\(value)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch let DecodingError.typeMismatch(type, context)  {
                print("Type '\(type)' mismatch:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch {
                print("error: ", error)
            }
        }
        
    }
}
