import SwiftUI
//import SwiftData
import HealthKit
import CoreLocation

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
    
    @State var openSearch: Bool = false
    @State var hasArrivedAtDestination : Bool = false
    @State var showMapView: Bool = false
    @State var isLoading: Bool = false
    @State private var searchContent: String = ""
    @State private var showDetail: Bool = false
    @State private var selectedCoffeeshop: CoffeeShopStruct? = nil
    @State var showAlertPopup: Bool = false
    
    @State private var updatedCoffeeShopsState: [CoffeeShopStruct] = []
    
    init() {
        UITextField.appearance().clearButtonMode = .whileEditing
    }
    
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
    
    @ViewBuilder
    func backgroundHeader() -> some View {
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                backgroundHeader()
                    .onTapGesture {
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    }
                mainContent()
            }
        }
        .onAppear {
                    // initial load for shops
                    updateCoffeeShopsWithCalories()
                }
        .onChange(of: userName) { _, newName in
            guard !newName.isEmpty else { return }
            locationManager.checkAuthorization()
            healthViewModel.requestAuthorization()
            
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
    
    @State private var searchText: String = ""
    
    func mainContent() -> some View {
        VStack(alignment: .leading, spacing: 0) {
            userProfile(streakManager: streakManager)
            HealthDashboardView(viewModel: healthViewModel, isLoading: $isLoading)
                .onTapGesture {
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }
            let filteredCoffeeShops = updatedCoffeeShopsState.filter { shop in
                searchText.isEmpty || shop.name.localizedCaseInsensitiveContains(searchText)
            }
            
            HStack {
                NavigationLink(destination: SearchListView(showMapView: $showMapView, coffeeShops: filteredCoffeeShops)) {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                        .padding(5)
                    Text("Where you wanna grab coffee?")
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(7)
                .background(RoundedRectangle(cornerRadius: 25).stroke(Color.brown))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.vertical, 24)
                
            }
            ScrollView {
                PopularBrandRow(shops: updatedCoffeeShopsState, showMapView: $showMapView)
                
                CategoryHome(coffeeShop: updatedCoffeeShopsState, showMapView: $showMapView)
            }
        }
        .padding(12)
        .ignoresSafeArea(.container, edges: .bottom)
        
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
                    .foregroundColor(.primary)
                    .fontWeight(.semibold)
                    .padding(.bottom, 4)
            }
        }
    }
}

#Preview {
    Homepage()
}
