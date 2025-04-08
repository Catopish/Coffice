//
//  ContentView.swift
//  Coffice
//
//  Created by Hafi on 20/03/25.
//

import SwiftUI
import SwiftData
import HealthKit
import CoreLocation

struct CoffeeShopStruct: Identifiable {
    var id = UUID()
    var name: String
    var location: String
    var description: String
    var distance: Double
    var steps: Int
    var calories: Int
    var latitude: Double
    var longitude: Double
}

@Observable
class filterModel: ObservableObject {
    var maxRange: Double
    init(maxRange: Double) {
        self.maxRange = maxRange
    }
}

struct Homepage: View {
    
    @AppStorage("userName") var userName: String = ""
    
    @StateObject private var healthViewModel = HealthDashboardViewModel()
    @StateObject var locationManager = LocationManager()
    @StateObject var mapWalkingManager = MapWalkingManager()
    
    @State var isLoading: Bool = false
    @State private var searchContent: String = ""
    @State private var showDetail: Bool = false
    @State private var selectedCoffeeshop: CoffeeShopStruct? = nil
    @State private var showOnboarding: Bool = false
    
    // Your original coffee shops array.
    let coffeeShop: [CoffeeShopStruct] = [
        CoffeeShopStruct(name: "Starbucks", location: "Lorem Ipsum", description: "lorem", distance: 0, steps: 123, calories: 0, latitude: -6.30191, longitude: 106.65438),
        CoffeeShopStruct(name: "Fore", location: "Lorem Ipsum", description: "lorem", distance: 0, steps: 54, calories: 0, latitude: -6.302514, longitude: 106.654299),
        CoffeeShopStruct(name: "36 Grams", location: "Lorem Ipsum", description: "lorem", distance: 0, steps: 54, calories: 0, latitude: -6.301446, longitude: 106.650023),
        CoffeeShopStruct(name: "Tamper", location: "Lorem Ipsum", description: "lorem", distance: 0, steps: 887, calories: 0, latitude: -6.30187, longitude: 106.654210),
        CoffeeShopStruct(name: "% Arabica", location: "Lorem Ipsum", description: "lorem", distance: 0, steps: 887, calories: 0, latitude: -6.30179, longitude: 106.65321),
        CoffeeShopStruct(name: "Kenangan Signature", location: "Lorem Ipsum", description: "lorem", distance: 0, steps: 412, calories: 0, latitude: -6.301535, longitude: 106.653458),
        CoffeeShopStruct(name: "Tabemori", location: "Lorem Ipsum", description: "lorem", distance: 0, steps: 102, calories: 0, latitude: -6.302768, longitude: 106.65347),
        CoffeeShopStruct(name: "Lawson", location: "Lorem Ipsum", description: "lorem", distance: 0, steps: 102, calories: 0, latitude: -6.302592, longitude: 106.65338)
    ]
    
    // Filter by the search text on the original array.
    var filteredCoffeeshop: [CoffeeShopStruct] {
        guard !searchContent.isEmpty else {
            return coffeeShop
        }
        return coffeeShop.filter { $0.name.localizedCaseInsensitiveContains(searchContent) }
    }
    
    // This state variable holds the updated results (after route calculation).
    @State private var updatedCoffeeShopsState: [CoffeeShopStruct] = []
    
    // A computed property to filter the updated results by the search text.
    var filteredUpdatedCoffeeShops: [CoffeeShopStruct] {
        guard !searchContent.isEmpty else {
            return updatedCoffeeShopsState
        }
        return updatedCoffeeShopsState.filter {
            $0.name.localizedCaseInsensitiveContains(searchContent)
        }
    }
    
    // Function that updates each coffee shop's distance (using route distance) and calories.
    func updateCoffeeShopsWithCalories() {
        guard let userLocation = locationManager.userLocation else { return }
        
        var newCoffeeShops: [CoffeeShopStruct] = []
        let group = DispatchGroup()
        
        // Use the original filtered array (based on search) here.
        for shop in filteredCoffeeshop {
            var updatedShop = shop
            let destinationCoordinate = CLLocationCoordinate2D(latitude: shop.latitude, longitude: shop.longitude)
            
            group.enter()
            // Calculate the route asynchronously.
            mapWalkingManager.calculateRoute(from: userLocation.coordinate, to: destinationCoordinate) { success in
                if success,
                   let travelTime = mapWalkingManager.travelTime,
                   let routeDistance = mapWalkingManager.distance {
                    updatedShop.distance = routeDistance
                    let estimatedCalories = mapWalkingManager.calculateCalories(for: routeDistance, at: 4.0, in: travelTime)
                    updatedShop.calories = estimatedCalories
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
    
    var body: some View {
        VStack(alignment: .leading) {
            userProfile()
            HealthDashboardView(viewModel: healthViewModel, isLoading: $isLoading)
            Text("Where’s your coffee taking you today?")
                .font(.headline)
                .fontWeight(.semibold)
                .padding()
            NavigationStack {
                VStack {
                    // Use the filtered updated results.
                    List(filteredUpdatedCoffeeShops) { shop in
                        Button(action: {
                            selectedCoffeeshop = shop
                            showDetail = true
                        }) {
                            HStack {
                                Text(shop.name)
                                    .foregroundColor(.primary)
                                Spacer()
                                Text("\(Int(shop.distance)) m")
                                    .foregroundColor(.primary)
                            }
                        }
                        .listRowSeparator(.hidden)
                    }
                    .background(Color.white)
                    .scrollContentBackground(.hidden)
                    .shadow(radius: 4)
                    .padding(.top, -30)
                }
            }
            .padding(.top, -20)
        }
        .overlay(
            coffeeshopInformation(showDetail: $showDetail, selectedCoffeeshop: $selectedCoffeeshop)
                .animation(.easeInOut, value: showDetail)
        )
        .onAppear {
            locationManager.checkAuthorization()
            healthViewModel.requestAuthorization()
            // Trigger update when the view appears.
            updateCoffeeShopsWithCalories()
        }
        // Update the list if the user's location changes.
        .onChange(of: locationManager.userLocation) { newLocation in
            if newLocation != nil {
                updateCoffeeShopsWithCalories()
            }
        }
        .alert(isPresented: $locationManager.showSettingsAlert) {
            Alert(
                title: Text("Location Permission Needed"),
                message: Text("Please enable location access in Settings."),
                primaryButton: .default(Text("Open Settings"), action: {
                    if let url = URL(string: UIApplication.openSettingsURLString) {
                        UIApplication.shared.open(url)
                    }
                }),
                secondaryButton: .cancel()
            )
        }
    }
}



#Preview {
    Homepage()
}
