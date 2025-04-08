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
    
    @State private var streak: Int = 0
    @State var isLoading: Bool = false
    @State private var searchContent: String = ""
    @State private var showDetail: Bool = false
    @State private var selectedCoffeeshop: CoffeeShopStruct? = nil
    @State private var showOnboarding: Bool = false
    
    let coffeeShop : [CoffeeShopStruct] = [
            CoffeeShopStruct(name: "Starbucks",location: "Lorem Ipsum", description: "lorem",distance: 127,steps: 123,calories: 123, latitude: -6.30191, longitude: 106.65438),
            CoffeeShopStruct(name: "Fore",location: "Lorem Ipsum", description: "lorem",distance: 45 ,steps: 54,calories: 134, latitude: -6.302514, longitude: 106.654299),
            CoffeeShopStruct(name: "36 Grams",location: "Lorem Ipsum", description: "lorem",distance: 45 ,steps: 54,calories: 134, latitude: -6.301446, longitude: 106.650023),
            CoffeeShopStruct(name: "Tamper",location: "Lorem Ipsum", description: "lorem",distance: 431,steps: 887,calories: 1223, latitude: -6.301870, longitude: 106.654210),
            CoffeeShopStruct(name: "% Arabica",location: "Lorem Ipsum", description: "lorem",distance: 431,steps: 887,calories: 1223, latitude: -6.30179, longitude: 106.65321),
            CoffeeShopStruct(name: "Kenangan Signature",location: "Lorem Ipsum", description: "lorem",distance: 134,steps: 412,calories: 531, latitude: -6.301535, longitude: 106.653458),
            CoffeeShopStruct(name: "Tabemori",location: "Lorem Ipsum", description: "lorem",distance: 256,steps: 102,calories: 45, latitude: -6.302768, longitude: 106.653470),
            CoffeeShopStruct(name: "Lawson",location: "Lorem Ipsum", description: "lorem",distance: 256,steps: 102,calories: 45, latitude: -6.302592, longitude: 106.653380)

        ]
    var filteredCoffeeshop: [CoffeeShopStruct] {
        guard !searchContent.isEmpty else {
            return coffeeShop
        }
        return coffeeShop
            .filter {
                $0.name.localizedCaseInsensitiveContains(searchContent)
            }
    }
    
    
    var body: some View {
        VStack(alignment: .leading){
//            if let status = locationManager.authorizationStatus {
//                switch status {
//                case .notDetermined:
//                    Text("Requesting authorization...")
//                case .authorizedAlways, .authorizedWhenInUse:
//                    Text ("Authorized")
//                case .denied, .restricted:
//                    Text("Authorization denied.")
//                @unknown default:
//                    Text("Authorization status unknown.")
//                }
//            } else {
//                Text("Authorization status not yet determined.")
//            }
            userProfile()
            HealthDashboardView(viewModel: healthViewModel, isLoading: $isLoading)
            Text("Where’s your coffee taking you today?")
                .font(.headline)
                .fontWeight(.semibold)
                .padding()
            NavigationStack{
                VStack() {
                    List(filteredCoffeeshop.sorted(by: {$0.distance < $1.distance})) { shop in
                        Button(action: {
                            selectedCoffeeshop = shop
                            showDetail = true
                        }){
                            HStack{
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
//                    .navigationTitle("Coffee Shops")
                    .searchable(text: $searchContent,placement: .navigationBarDrawer(displayMode: .always))
                    .padding(.top, -30)
                }
            }
            .padding(.top, -20)
        }.overlay(
            coffeeshopInformation(showDetail: $showDetail, selectedCoffeeshop: $selectedCoffeeshop)
                .animation(.easeInOut, value: showDetail)
        )
//        .onAppear{
//            locationManager.checkAuthorization()
//            healthViewModel.requestAuthorization()
//        }
//        .alert(isPresented: $locationManager.showSettingsAlert) {
//            Alert(
//                title: Text("Location Permission Needed"),
//                message: Text("Please enable location access in Settings."),
//                primaryButton: .default(Text("Open Settings"), action: {
//                    if let url = URL(string: UIApplication.openSettingsURLString) {
//                        UIApplication.shared.open(url)
//                    }
//                }),
//                secondaryButton: .cancel()
//            )
//        }
    }
}


//struct userProfile: View {
//    @AppStorage("userName") var userName: String = ""
//    var body: some View {
//        HStack {
//            VStack (alignment: .leading) {
//                Text("Hi, \(userName)!")
//                    .font(.title)
//                    .fontWeight(.semibold)
//                //                    .padding(.vertical)
//                
//                Text("Let’s walk and sip! ☕️")
//                    .font(.subheadline)
//                    .foregroundColor(.secondary)
//                    .lineLimit(2)
//            }
//            .padding()
//            Spacer()
//            
//            HStack{
//                Text ("[X] Streak")
//                Image(systemName: "flame.fill")
//            }
//            
//            .padding()
//            .background(Color.brown2)
//            .foregroundColor(.white)
//            .clipShape(RoundedRectangle(cornerRadius: 10))
//            .frame(width: 150, height: 20)
//            .padding(.horizontal)
//        }
////        .fullScreenCover(isPresented: $showOnboarding) {
////            OnboardingView()
////        }
//    }
//}

//struct ContentView: View {
//    @AppStorage("userName") var userName: String = ""
//    
//    var body: some View {
//        if userName.isEmpty {
//            OnboardingView()
//        } else {
//            Homepage()
//        }
//    }
//}

struct userProfile: View {
    @AppStorage("userName") var userName: String = ""
    @StateObject var streakManager = StreakManager()
    var body: some View {
        HStack {
            VStack (alignment: .leading) {
                Text("Hi, \(userName)!")
                    .font(.title)
                    .fontWeight(.semibold)
                Text("Let’s walk and sip! ☕️")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
            }
            .padding()
            Spacer()
            
            HStack{
                Text ("\(streakManager.streak) Streak")
                Image(systemName: "flame.fill")
            }
            
            .padding()
            .background(Color.brown2)
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .frame(width: 150, height: 20)
            .padding(.horizontal, 5)
        }
    }
}


#Preview {
    Homepage()
}
