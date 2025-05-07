//
//  SearchView.swift
//  Coffice
//
//  Created by Angel on 06/05/25.
//

import SwiftUI

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
            }
            .listRowInsets(EdgeInsets())
            .padding(.horizontal, 15)
            .padding(5)
            .padding(.vertical, 6)

        }
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
    }
}

import SwiftUI
//
//struct CoffeeShop: Identifiable {
//    let id = UUID()
//    let name: String
//    let calories: Int
//    let steps: Int
//}

struct SearchListView: View {
    @State private var searchText = ""
//    
//    let coffeeShops: [CoffeeShop] = [
//        CoffeeShop(name: "% Arabica", calories: 12, steps: 181),
//        CoffeeShop(name: "Tamper", calories: 12, steps: 181),
//        CoffeeShop(name: "Kenangan Signature", calories: 12, steps: 181),
//        CoffeeShop(name: "Starbucks", calories: 12, steps: 181),
//        CoffeeShop(name: "Lawson", calories: 12, steps: 181),
//        CoffeeShop(name: "Fore", calories: 12, steps: 181),
//        CoffeeShop(name: "Tabemori", calories: 12, steps: 181)
//    ]
//    
//    var filteredShops: [CoffeeShop] {
//        if searchText.isEmpty {
//            return coffeeShops
//        } else {
//            return coffeeShops.filter { $0.name.lowercased().contains(searchText.lowercased()) }
//        }
//    }
    var coffeeShops: [CoffeeShopStruct]
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Button(action: {
                        // Back action
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.brown)
                    }

                    TextField("Search coffee shop", text: $searchText)
                        .padding(10)
                        .background(RoundedRectangle(cornerRadius: 10).stroke(Color.brown))
                        .padding(.horizontal)

                    Button(action: {
                        // Filter action
                    }) {
                        Image(systemName: "line.3.horizontal.decrease.circle")
                            .foregroundColor(.brown)
                    }
                }
                .padding(.horizontal)

                List(coffeeShops) { shop in
                    HStack {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.gray.opacity(0.3))
                            .frame(width: 40, height: 40)

                        VStack(alignment: .leading) {
                            Text(shop.name)
                                .fontWeight(.semibold)
                            
                            HStack(spacing: 10) {
                                Label("\(shop.calories) kcal", systemImage: "flame.fill")
                                    .foregroundColor(.gray)
                                    .font(.subheadline)
                                
                                Label("\(shop.steps) steps", systemImage: "figure.walk")
                                    .foregroundColor(.gray)
                                    .font(.subheadline)
                            }
                        }
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundColor(.gray)
                    }
                    .padding(.vertical, 5)
                }
                .listStyle(PlainListStyle())
            }
            .navigationBarTitle("Where you wanna grab coffee?", displayMode: .inline)
        }
    }
}
//#Preview {
//    SearchListView()
//}
