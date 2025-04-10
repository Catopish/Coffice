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
    var logo: String
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
    
    @StateObject var streakManager = StreakManager()
    @StateObject private var healthViewModel = HealthDashboardViewModel()
    @StateObject var locationManager = LocationManager()
    @StateObject var mapWalkingManager = MapWalkingManager()
    @StateObject var liveViewModel = LiveActivityViewModel()
    
    @State var hasArrivedAtDestination : Bool = false
    @State var showMapView: Bool = false
    @State var isLoading: Bool = false
    @State private var searchContent: String = ""
    @State private var showDetail: Bool = false
    @State private var selectedCoffeeshop: CoffeeShopStruct? = nil
//    @State private var showOnboarding: Bool = false
    @State var showAlertPopup: Bool = false
    
    @State private var updatedCoffeeShopsState: [CoffeeShopStruct] = []
    
    init(){
        UITextField.appearance().clearButtonMode = .whileEditing
    }
    
    let coffeeShop: [CoffeeShopStruct] = [
        CoffeeShopStruct(name: "Starbucks", location: "The Breeze", description: "lorem", distance: 0, steps: 0, calories: 0, latitude: -6.30191, longitude: 106.65438, logo: "sbux"),
        CoffeeShopStruct(name: "Fore", location: "The Breeze", description: "lorem", distance: 0, steps: 0, calories: 0, latitude: -6.302514, longitude: 106.654299, logo: "forelogo"),
        CoffeeShopStruct(name: "36 Grams", location: "GOP 1", description: "lorem", distance: 0, steps: 0, calories: 0, latitude: -6.301446, longitude: 106.650023, logo: "36grams"),
        CoffeeShopStruct(name: "Tamper", location: "The Breeze", description: "lorem", distance: 0, steps: 0, calories: 0, latitude: -6.301870, longitude: 106.654210, logo: "tamperlogo"),
        CoffeeShopStruct(name: "% Arabica", location: "The Breeze", description: "lorem", distance: 0, steps: 0, calories: 0, latitude: -6.30179, longitude: 106.65321, logo: "arabica"),
        CoffeeShopStruct(name: "Kenangan Signature", location: "The Breeze", description: "lorem", distance: 0, steps: 0, calories: 531, latitude: -6.301535, longitude: 106.653458, logo: "kenangan"),
        CoffeeShopStruct(name: "Tabemori", location: "GOP 6", description: "lorem", distance: 0, steps: 0, calories: 0, latitude: -6.302768, longitude: 106.653470, logo: "tabemorilogo"),
        CoffeeShopStruct(name: "Apple Academy", location: "GOP 9", description: "lorem", distance: 0, steps: 0, calories: 0, latitude: -6.302168805766506, longitude: 106.65218820473441, logo: "sbux"),
        CoffeeShopStruct(name: "Lawson", location: "GOP 6", description: "lorem", distance: 0, steps: 0, calories: 0, latitude: -6.302592, longitude: 106.653380, logo: "lawsonlogo")
    ]

        // Function that updates each coffee shop's distance (using route distance) and calories.
        func updateCoffeeShopsWithCalories() {
            guard let userLocation = locationManager.userLocation else { return }
            
            var newCoffeeShops: [CoffeeShopStruct] = []
            let group = DispatchGroup()
            
            // Use the original filtered array (based on search) here.
            for shop in coffeeShop {
                var updatedShop = shop
                let destinationCoordinate = CLLocationCoordinate2D(latitude: shop.latitude, longitude: shop.longitude)
                
                group.enter()
                // Calculate the route asynchronously.
                mapWalkingManager.calculateRoute(from: userLocation.coordinate, to: destinationCoordinate) { success in
                    if success,
                       let travelTime = mapWalkingManager.travelTime,
                       let routeDistance = mapWalkingManager.distance {
                        updatedShop.distance = routeDistance
                        let estimatedCalories = mapWalkingManager.calculateCaloriesBurned(for: routeDistance, at: 4.0, in: travelTime)
                        updatedShop.calories = estimatedCalories
                        let estimatedSteps = mapWalkingManager.calculateSteps(for: routeDistance)
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

    var body: some View {
        ZStack {
            backgroundHeader()
                .onTapGesture {
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }
            mainContent()
        }
        //        .onAppear {
//            locationManager.checkAuthorization()
////            if userName.isEmpty { showOnboarding = true }
//            updateCoffeeShopsWithCalories()
//            streakManager.completeToday()
//        }
        .onChange(of: userName) { _, newName in
            guard !newName.isEmpty else { return }
            // 1) Location auth
            locationManager.checkAuthorization()
            // 2) HealthKit auth (you’ll want to make this async in your VM)
            healthViewModel.requestAuthorization()
            // 3) Any other startup tasks
        }
        .onChange(of: locationManager.userLocation) { _, newLocation in
            if newLocation != nil {
                updateCoffeeShopsWithCalories()
            }
        }
        .fullScreenCover(isPresented: $showMapView) {
            MapView(streakManager: streakManager, coffeShops: $selectedCoffeeshop,liveViewModel: liveViewModel,hasArrivedAtDestination: $hasArrivedAtDestination)
        }
        .fullScreenCover(isPresented: $streakManager.shouldShowStreak) {
            AlertStreak(streakManager: streakManager)
        }
//        .fullScreenCover(isPresented: $showOnboarding) { OnboardingView() }
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

    @ViewBuilder
    func backgroundHeader() -> some View {
        VStack(spacing: 0) {
            Color.brown2.frame(height: 200)
            Spacer()
        }
        .ignoresSafeArea()
        
        VStack(spacing: 0) {
            Image("cofe")
                .resizable()
                .scaledToFill()
                .frame(height: 200)
            Spacer()
        }
        .ignoresSafeArea()
    }

    @State private var searchText: String = ""

    func mainContent() -> some View {
        VStack(alignment: .leading, spacing: 0) {
            userProfile(streakManager: streakManager)
            HealthDashboardView(viewModel: healthViewModel, isLoading: $isLoading)
                .onTapGesture {
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }

            
            Text ("Where’s your coffee taking you today?")
                .font(.headline)
                .padding(.leading, 18)
            
            HStack {
                Image(systemName: "magnifyingglass")
                    .font(.caption)
                    .foregroundColor(.white)
                    .padding(3)
                    .background(Color.brown2)
                    .cornerRadius(4)
                    .padding(.trailing, 5)

                TextField("Search", text: $searchText)
                    .foregroundColor(.primary)
                    .autocapitalization(.none)
            }
            .padding(7)
            .background(Color.gray.opacity(0.1))
            .cornerRadius(6)
            .padding()
            .padding(.vertical, -10)

            let filteredCoffeeShops = updatedCoffeeShopsState.filter { shop in
                searchText.isEmpty || shop.name.localizedCaseInsensitiveContains(searchText)
            }
            NavigationStack {
                CoffeeShopListView(
//                    coffeeShops: updatedCoffeeShopsState,
                    coffeeShops: filteredCoffeeShops,
                    selectedCoffeeshop: $selectedCoffeeshop,
                    showDetail: $showDetail
                )
            }
        }
        .overlay(
            coffeeshopInformation(showMapView:$showMapView, showDetail: $showDetail, selectedCoffeeshop: $selectedCoffeeshop)
                .animation(.easeInOut, value: showDetail)
        )
    }
}

struct CoffeeShopListView: View {
    var coffeeShops: [CoffeeShopStruct]
    @Binding var selectedCoffeeshop: CoffeeShopStruct?
    @Binding var showDetail: Bool

    var body: some View {
        List(coffeeShops) { shop in
            Button(action: {
                selectedCoffeeshop = shop
                showDetail = true
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }) {
                HStack(alignment: .center, spacing: 8) {
                    Image(shop.logo)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 35, height: 35)
                        .clipShape(Circle())
                        .padding(.trailing, 5)
                    VStack(alignment: .leading) {
                        HStack{
                            Text(shop.name)
                                .font(.subheadline)
                            
                            Spacer()
                            Text("\(Int(shop.distance)) m")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                                .padding(.trailing, 5)
                        }
                    }
                }
//                .padding(10)
//                .frame(maxWidth: .infinity, alignment: .leading)
//                .background(Color.white)
//                .cornerRadius(8)
//                .shadow(color: Color.black.opacity(0.3), radius: 3, x: 0, y: 1)
            }
            .listRowInsets(EdgeInsets())
//            .listRowSeparator(.hidden)
            .padding(.horizontal, 15)
            .padding(5)
            .padding(.vertical, 6)

        }
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
    }
}

struct userProfile: View {
    @AppStorage("userName") var userName: String = ""
    @ObservedObject var streakManager : StreakManager
    

//    let daysStreak = UserDefaults.standard.integer(forKey: "streak")
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Hi, \(userName)!")
                    .font(.title)
                    .foregroundColor(.white)
                    .fontWeight(.semibold)
                    .padding(.leading, 6)
                Text("Let’s walk and sip! ☕️")
                    .font(.subheadline)
                    .foregroundColor(.white)
                    .lineLimit(2)
                    .padding(.leading, 6)
            }
            .padding()
            Spacer()
            VStack {
                Image(systemName: "flame.fill")
                    .font(.title)
                    .padding(.trailing, 6)
                Text("\(streakManager.streak) streak")
                    .padding(.trailing, 6)
            }
            .padding()
            .foregroundColor(.white)
            .padding(.horizontal, 5)
        }
    }
}

#Preview {
    Homepage()
}
