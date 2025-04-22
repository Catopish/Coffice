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
            UserProfile(streakManager: viewModel.streakManager)
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





#Preview {
    Homepage()
}
