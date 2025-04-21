//
//  HomepageViewModel.swift
//  Coffice
//
//  Created by Hafi on 21/04/25.
//

import Foundation

extension Homepage {
    @Observable
    class ViewModel {
        var coffeeShops: [CoffeeShops] = []
        
        init () {
            loadCoffeeShops()
        }
        
        var streakManager = StreakManager()
        var healthViewModel = HealthDashboardViewModel()
        var locationManager = LocationManager()
        var mapWalkingManager = MapWalkingManager()
        var liveViewModel = LiveActivityViewModel()
        
        func loadCoffeeShops() {
            guard let url = Bundle.main.url(forResource: "coffee_shops", withExtension: "json"),
                  let data = try? Data(contentsOf: url),
                  let decoded = try? JSONDecoder().decode([CoffeeShops].self, from: data) else {
                print("Failed to load coffee shops JSON.")
                return
            }
            
            self.coffeeShops = decoded
        }
    }
}
