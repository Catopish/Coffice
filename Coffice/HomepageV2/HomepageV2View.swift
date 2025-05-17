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
    @EnvironmentObject var preferencesManager: PreferencesManager
    @StateObject private var healthViewModel = HealthDashboardViewModel()
    @StateObject var locationManager = LocationManager()
    @StateObject private var viewModel = HomepageV2ViewModel()
    @State private var featuredTags: [CoffeeTag] = []
    @State var isLoading: Bool = false
    @State private var searchText: String = ""
    @State private var selectedCoffeeshop: CoffeeShopStruct? = nil
    @State private var showDetail: Bool = false
    func tagLine(for tag: CoffeeTag) -> String {
        return preferenceTagLines.first(where: { $0.associatedTag == tag })?.tagLine ?? ""
    }
    func getRecommendedMenus(for tag: CoffeeTag, from shops: [CoffeeShopStruct]) -> [CoffeeMenuStruct] {
        return shops
            .flatMap { $0.menu }
            .filter { $0.tag1 == tag || $0.tag2 == tag || $0.tag3 == tag }
    }
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
                    HealthDashboardView(viewModel: healthViewModel, isLoading: $isLoading)
                    if featuredTags.count > 0 {
                        let recommendedForFirstTag = getRecommendedMenus(for: featuredTags[0], from: coffeeShopV2)
                        Text(tagLine(for: featuredTags[0]))
                            .foregroundStyle(.black)
                            .padding(.leading, 20)
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                ForEach(recommendedForFirstTag, id: \.id) { menu in
                                    if let shop = coffeeShopV2.first(where: { $0.menu.contains(where: { $0.id == menu.id }) }) {
                                        NavigationLink(
                                            destination: CoffeeShopDetailView(selectedCoffeeShop: shop)
                                        ) {
                                            SlimCoffeeCard(coffee: menu, shopName: shop.name)
                                        }
                                    }
                                }
                                
                            }
                            .padding(.horizontal, 20)
                    }
                    if featuredTags.count > 1 {
                        let recommendedForSecondTag = featuredTags.count > 1 ? getRecommendedMenus(for: featuredTags[1], from: coffeeShopV2) : []
                        Text(tagLine(for: featuredTags[1]))
                            .foregroundStyle(.black)
                            .padding(.leading, 20)
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                ForEach(recommendedForSecondTag, id: \.id) { menu in
                                    if let shop = coffeeShopV2.first(where: { $0.menu.contains(where: { $0.id == menu.id }) }) {
                                        NavigationLink(
                                            destination: CoffeeShopDetailView(selectedCoffeeShop: shop)
                                        ) {
                                            SlimCoffeeCard(coffee: menu, shopName: shop.name)
                                        }
                                    }
                                }
                            }
                            .padding(.horizontal, 20)
                        }
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
                                        }
                }
                
            }
            .onAppear {
                featuredTags = preferencesManager.getRandomPreferredTags()
                print(featuredTags)
            }
            .onChange(of: userName) { _, newName in
                guard !newName.isEmpty else { return }
                locationManager.checkAuthorization()
                healthViewModel.requestAuthorization()
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
    @AppStorage("completedPreferences") var hasCompletedPreferences: Bool = false
    @AppStorage("userPreferences") var storedPreferences: String = ""

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
            Spacer()
            Button {
                userName = ""
                hasCompletedPreferences = false
                storedPreferences = ""
            } label: {
                Text("Reset")
                    .foregroundColor(.red)
            }
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
                destination: CoffeeShopDetailView(selectedCoffeeShop: shop)
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
        .environmentObject(PreferencesManager())
}
