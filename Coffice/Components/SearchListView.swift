//
//  SearchListView.swift
//  Coffice
//
//  Created by Angel on 12/05/25.
//


import SwiftUI

struct SearchListView: View {
    @State private var searchText = ""
    @State private var showFilterSheet = false
    @State private var isFilterActive = false
    @Binding var showMapView: Bool
    @State private var selectedCoffeeTypes: Set<String> = []
    @State private var selectedDistance: String? = nil
    @State private var selectedPrice: String? = nil

    var coffeeShops: [CoffeeShopStruct]

    var filteredCoffeeShops: [CoffeeShopStruct] {
        var filtered = coffeeShops

        if !selectedCoffeeTypes.isEmpty {
            filtered = filtered.filter { shop in
                shop.menu.contains { selectedCoffeeTypes.contains($0.type) }
            }
        }

        if let distance = selectedDistance {
            filtered = filtered.sorted(by: {
                distance == "Farthest" ? $0.distance > $1.distance : $0.distance < $1.distance
            })
        }

        if let price = selectedPrice {
            filtered = filtered.sorted(by: { a, b in
                let minA = a.menu.map { $0.price }.min() ?? 0
                let minB = b.menu.map { $0.price }.min() ?? 0
                return price == "Cheapest" ? minA < minB : minA > minB
            })
        }

        if !searchText.isEmpty {
            filtered = filtered.filter { shop in
                shop.name.lowercased().contains(searchText.lowercased())
            }
        }

        return filtered
    }

    var body: some View {
//        NavigationView {
            VStack {
                VStack(alignment: .leading, spacing: 20) {
                    HStack {
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
                            TextField("Search coffee shop", text: $searchText)
                                .foregroundColor(.primary)
                        }
                        .padding(10)
                        .background(
                            RoundedRectangle(cornerRadius: 25)
                                .stroke(Color.brown, lineWidth: 1)
                        )

                        Button(action: {
                            showFilterSheet = true
                        }) {
                            Image(systemName: "line.3.horizontal.decrease")
                                .foregroundColor(isFilterActive ? Color("brown2") : .brown2)
                                .padding(10)
                                .background(
                                    Circle()
                                        .fill(isFilterActive ? Color("brown5") : Color.white)
                                        .stroke(isFilterActive ? Color("brown2") : Color.brown2, lineWidth: 1)
                                )
                        }
                        .sheet(isPresented: $showFilterSheet) {
                            FilterSheetView(
                                initialCoffeeTypes: selectedCoffeeTypes,
                                initialDistance: selectedDistance,
                                initialPrice: selectedPrice,
                                onApplyFilter: { coffeeTypes, distance, price in
                                    selectedCoffeeTypes = coffeeTypes
                                    selectedDistance = distance
                                    selectedPrice = price
                                    isFilterActive = !coffeeTypes.isEmpty || distance != nil || price != nil
                                    showFilterSheet = false
                                }
                            )
                        }

                    }
                }
                .padding(.horizontal)

                List(filteredCoffeeShops) { shop in
                    NavigationLink(destination: DetailedInformation(shop: shop, showMapView: $showMapView)) {
                        HStack(spacing: 8) {
                            Image(shop.logo)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 60, height: 60)
                                .clipShape(Circle())
                                .padding(.trailing, 8)
                                .shadow(radius: 1)

                            VStack(alignment: .leading, spacing: 8) {
                                Text(shop.name)
                                    .font(.headline).bold()

                                HStack(spacing: 16) {
                                    HStack(spacing: 4) {
                                        Image(systemName: "flame.fill")
                                        Text("\(shop.calories) kcal")
                                    }
                                    .foregroundColor(.gray)
                                    .font(.body)

                                    HStack(spacing: 4) {
                                        Image(systemName: "figure.walk")
                                        Text("\(shop.steps) steps")
                                    }
                                    .foregroundColor(.gray)
                                    .font(.body)
                                }
                            }
                        }
                    }
                    .listRowSeparator(.hidden)
                    .padding(.vertical, 4)
                }
                .listStyle(.plain)
            }
    }
}

//#Preview {
//    SearchListView(coffeeShops: coffeeShop)
//}
