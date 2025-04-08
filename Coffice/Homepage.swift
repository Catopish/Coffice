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
    @State private var streak: Int = 0
    @AppStorage("userName") var userName: String = ""
    @StateObject private var healthViewModel = HealthDashboardViewModel()
    @State var isLoading: Bool = false
    @StateObject var locationManager = LocationManager()
    @State private var searchContent: String = ""
    @State private var showDetail: Bool = false
    @State private var selectedCoffeeshop: CoffeeShopStruct? = nil
    @State private var showOnboarding: Bool = false
    @State var showAlertPopup: Bool = false

    let coffeeShop: [CoffeeShopStruct] = [
        CoffeeShopStruct(name: "Starbucks", location: "Lorem Ipsum", description: "lorem", distance: 127, steps: 123, calories: 123, latitude: -6.30191, longitude: 106.65438, logo: "sbux"),
        CoffeeShopStruct(name: "Fore", location: "Lorem Ipsum", description: "lorem", distance: 45, steps: 54, calories: 134, latitude: -6.302514, longitude: 106.654299, logo: "fore"),
        CoffeeShopStruct(name: "36 Grams", location: "Lorem Ipsum", description: "lorem", distance: 45, steps: 54, calories: 134, latitude: -6.301446, longitude: 106.650023, logo: "36grams"),
        CoffeeShopStruct(name: "Tamper", location: "Lorem Ipsum", description: "lorem", distance: 431, steps: 887, calories: 1223, latitude: -6.301870, longitude: 106.654210, logo: "tamper"),
        CoffeeShopStruct(name: "% Arabica", location: "Lorem Ipsum", description: "lorem", distance: 431, steps: 887, calories: 1223, latitude: -6.30179, longitude: 106.65321, logo: "arabica"),
        CoffeeShopStruct(name: "Kenangan Signature", location: "Lorem Ipsum", description: "lorem", distance: 134, steps: 412, calories: 531, latitude: -6.301535, longitude: 106.653458, logo: "kenangan"),
        CoffeeShopStruct(name: "Tabemori", location: "Lorem Ipsum", description: "lorem", distance: 256, steps: 102, calories: 45, latitude: -6.302768, longitude: 106.653470, logo: "tabemori"),
        CoffeeShopStruct(name: "Lawson", location: "Lorem Ipsum", description: "lorem", distance: 256, steps: 102, calories: 45, latitude: -6.302592, longitude: 106.653380, logo: "lawson")
    ]

    var filteredCoffeeShop: [CoffeeShopStruct] {
        guard !searchContent.isEmpty else { return coffeeShop }
        return coffeeShop.filter { $0.name.localizedCaseInsensitiveContains(searchContent) }
    }

    var sortedFilteredCoffeeShop: [CoffeeShopStruct] {
        filteredCoffeeShop.sorted { $0.distance < $1.distance }
    }

    var body: some View {
        ZStack {
            backgroundHeader()
            mainContent()
        }
        .onAppear {
            locationManager.checkAuthorization()
            if userName.isEmpty { showOnboarding = true }
        }
        .fullScreenCover(isPresented: $showOnboarding) { OnboardingView() }
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

    @ViewBuilder
    func mainContent() -> some View {
        VStack(alignment: .leading, spacing: 0) {
            userProfile()
            HealthDashboardView(viewModel: healthViewModel, isLoading: $isLoading)
            Text("Where’s your coffee taking you today?")
                .font(.headline)
                .fontWeight(.semibold)
                .padding()

            NavigationStack {
                CoffeeShopListView(
                    coffeeShops: sortedFilteredCoffeeShop,
                    selectedCoffeeshop: $selectedCoffeeshop,
                    showDetail: $showDetail
                )
            }
        }
        .overlay(
            coffeeshopInformation(showDetail: $showDetail, selectedCoffeeshop: $selectedCoffeeshop)
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
            }) {
                HStack(alignment: .center, spacing: 8) {
                    Image(shop.logo)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
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
                .padding(10)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.white)
                .cornerRadius(10)
                .shadow(color: Color.black.opacity(0.3), radius: 3, x: 0, y: 1)
            }
            .listRowInsets(EdgeInsets())
            .listRowSeparator(.hidden)
            .padding(.horizontal, 16)
            .padding(.vertical, 6)
        }
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
    }
}

struct userProfile: View {
    @AppStorage("userName") var userName: String = ""
    @StateObject var streakManager = StreakManager()

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Hi, \(userName)!")
                    .font(.title)
                    .foregroundColor(.white)
                    .fontWeight(.semibold)
                    .padding(.leading, 10)
                Text("Let’s walk and sip! ☕️")
                    .font(.subheadline)
                    .foregroundColor(.white)
                    .lineLimit(2)
                    .padding(.leading, 10)
            }
            .padding()
            Spacer()
            VStack {
                Image(systemName: "flame.fill")
                    .font(.title)
                    .padding(.trailing, 10)
                Text("\(streakManager.streak) streak")
                    .padding(.trailing, 10)
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
