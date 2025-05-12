//
//  HomepageV2ViewModel.swift
//  Coffice
//
//  Created by Al Amin Dwiesta on 12/05/25.
//

import Foundation
import SwiftUI
import CoreLocation

class HomepageV2ViewModel:ObservableObject {
    @Published var updatedCoffeeShopsState: [CoffeeShopStruct] = []
    
    let locationManager = LocationManager()
    let mapWalkingManager = MapWalkingManager()
        
    func updateCoffeeShopsByDistance(coffeeshops: [CoffeeShopStruct]) {
        
        guard let userLocation = locationManager.userLocation else { return }
        
        var newCoffeeShops: [CoffeeShopStruct] = []
        let group = DispatchGroup()
        
        // Use the original filtered array (based on search) here.
        for shop in coffeeshops {
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
}
