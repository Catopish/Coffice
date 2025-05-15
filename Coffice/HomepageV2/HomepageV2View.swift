//
//  HomepageV2.swift
//  Coffice
//
//  Created by Al Amin Dwiesta on 09/05/25.
//

import SwiftUI
import Foundation

struct HomepageV2: View {
    @AppStorage("userName") var userName: String = ""
    
    @StateObject private var healthViewModel = HealthDashboardViewModel()
    @StateObject var locationManager = LocationManager()
    @StateObject private var viewModel = HomepageV2ViewModel()
    
    @State var isLoading: Bool = false
    @State private var searchText: String = ""
    @State private var selectedCoffeeshop: CoffeeShopStruct? = nil
    @State private var showDetail: Bool = false
    
    var body: some View {
        
        NavigationStack{
            ZStack(alignment: .leading) {
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color(red: 0.86, green: 0.64, blue: 0.50),
                        .white
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
                
                VStack(alignment: .leading) {
                    userProfileV2()
//                    ScrollView(.vertical, showsIndicators: false){
                        HealthDashboardView(viewModel: healthViewModel, isLoading: $isLoading)
                        Text("Recommendation Sweet")
                            .foregroundStyle(.black)
                            .padding(.leading,20)
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                //                        ForEach(coffeeItems, id: \.self) { _ in
                                SlimCoffeeCard()
                                SlimCoffeeCard()
                                SlimCoffeeCard()
                                SlimCoffeeCard()
                                SlimCoffeeCard()
                                //                        }
                            }
                            .padding(.horizontal, 20)
                        }
                        Text("Recommendation black")
                            .foregroundStyle(.black)
                            .padding(.leading,20)
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                //                        ForEach(coffeeItems, id: \.self) { _ in
                                SlimCoffeeCard()
                                SlimCoffeeCard()
                                SlimCoffeeCard()
                                SlimCoffeeCard()
                                SlimCoffeeCard()
                                //                        }
                            }
                            .padding(.horizontal, 20)
                        }
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
                        CoffeeShopListView(
                            coffeeShops: filteredCoffeeShops,
                            selectedCoffeeshop: $selectedCoffeeshop,
                            showDetail: $showDetail
                        )
//                    }
                }
                
            }
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
                    viewModel.updateCoffeeShopsByDistance(coffeeshops: coffeeShopV2)
                }
            }
        }
        
    }
}


struct userProfileV2: View {
    @AppStorage("userName") var userName: String = ""
    
    var body: some View {
        HStack()  {
            VStack(alignment: .leading) {
                Text("Hi, \(userName)!")
                    .font(.title)
                    .foregroundColor(.white)
                    .fontWeight(.semibold)
                //                    .padding(.leading, 6)
            }
            .padding(.leading,20)
        }
    }
}
struct CoffeeShopListView: View {
    var coffeeShops: [CoffeeShopStruct]
    @Binding var selectedCoffeeshop: CoffeeShopStruct?
    @Binding var showDetail: Bool
    
    var body: some View {
        List(coffeeShops) { shop in
            NavigationLink(
                destination: CoffeeShopDetailView(/*coffeeShop: shop*/)
            ) {
                HStack {
                    Text(shop.name)
                        .font(.body)
                        .foregroundColor(.primary)
                    Spacer()
                    Text("\(Int(shop.distance)) m")
                        .font(.body)
                        .foregroundColor(.gray)
                }
                .padding(.vertical, 4)
            }
            .listRowBackground(Color.clear)
        }
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
    }
}

#Preview {
    HomepageV2()
}
