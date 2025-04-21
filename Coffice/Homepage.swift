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

@Observable
class filterModel: ObservableObject {
    var maxRange: Double
    init(maxRange: Double) {
        self.maxRange = maxRange
    }
}

struct Homepage: View {
    @AppStorage("userName") var userName: String = ""
    @State private var viewModel = ViewModel()
    
    @State var hasArrivedAtDestination : Bool = false
    @State var showMapView: Bool = false
    @State var isLoading: Bool = false
    @State private var searchContent: String = ""
    @State private var showDetail: Bool = false
    @State private var selectedCoffeeshop: CoffeeShops? = nil
    @State var showAlertPopup: Bool = false
    
    init(){
        UITextField.appearance().clearButtonMode = .whileEditing
    }

    var body: some View {
        ZStack {
            backgroundHeader()
                .onTapGesture {
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }
            mainContent()
        }
        .onChange(of: userName) { _, newName in
            guard !newName.isEmpty else { return }
            
            viewModel.locationManager.checkAuthorization()
            viewModel.healthViewModel.requestAuthorization()
    
        }
        .onChange(of: viewModel.locationManager.userLocation) { _, newLocation in
            if newLocation != nil {
                viewModel.updateCoffeeShopsWithCalories()
            }
        }
        .fullScreenCover(isPresented: $showMapView) {
            MapView(streakManager: viewModel.streakManager, coffeShops: $selectedCoffeeshop,liveViewModel: viewModel.liveViewModel,hasArrivedAtDestination: $hasArrivedAtDestination)
        }
        .fullScreenCover(isPresented: $viewModel.streakManager.shouldShowStreak) {
            AlertStreak(streakManager: viewModel.streakManager)
        }
//        .fullScreenCover(isPresented: $showOnboarding) { OnboardingView() }
        .alert(isPresented: $viewModel.locationManager.showSettingsAlert) {
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
            userProfile(streakManager: viewModel.streakManager)
            HealthDashboardView(viewModel: viewModel.healthViewModel, isLoading: $isLoading)
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

            let filteredCoffeeShops = viewModel.updatedCoffeeShopsState.filter { shop in
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
                .animation(Animation.easeInOut, value: showDetail)
        )
    }
}

struct CoffeeShopListView: View {
    var coffeeShops: [CoffeeShops]
    @Binding var selectedCoffeeshop: CoffeeShops?
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
