//
//  CoffeeShopListView.swift
//  Coffice
//
//  Created by Hafi on 22/04/25.
//


import SwiftUI
import SwiftData
import HealthKit
import CoreLocation

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
