//
//  ContentView.swift
//  Coffice
//
//  Created by Hafi on 20/03/25.
//

import SwiftUI
import SwiftData

struct CoffeeShopStruct: Identifiable {
    var id = UUID()
    var name: String
    var description: String
    var distance: Double
    var steps: Int
    var calories: Int
}

struct Homepage: View {
    
    @State private var searchContent: String = ""
    @State private var showDetail: Bool = false
    @State private var selectedCoffeeshop: CoffeeShopStruct? = nil
    
    let coffeeShop : [CoffeeShopStruct] = [
        CoffeeShopStruct(name: "Starbucks",description: "lorem",distance: 127,steps: 123,calories: 123),
        CoffeeShopStruct(name: "Fore",description: "lorem",distance: 45 ,steps: 54,calories: 134),
        CoffeeShopStruct(name: "Tamper",description: "lorem",distance: 431,steps: 887,calories: 1223),
        CoffeeShopStruct(name: "Kopi Kenangan",description: "lorem",distance: 134,steps: 412,calories: 531),
        CoffeeShopStruct(name: "Dunkin Donuts",description: "lorem",distance: 486,steps: 212,calories: 431)
    ]
    //    ["Starbucks","Fore","Tamper","Kopi Kenangan","Dunkin Donuts"]
    
    var filteredCoffeeshop: [CoffeeShopStruct] {
        guard !searchContent.isEmpty else {
            return coffeeShop
        }
        return coffeeShop.filter {
            $0.name.localizedCaseInsensitiveContains(searchContent)
        }
    }
    
    
    
    var body: some View {
        VStack(alignment: .leading){
            Color.blue
                .frame(height: 100)
            Color.red
                .frame(height: 150)
            VStack{
                
                NavigationView{
                    List(filteredCoffeeshop) { shop in
                        Button(action: {
                            selectedCoffeeshop = shop
                            showDetail = true
                        }) {
                            Text(shop.name)
                                .foregroundColor(.primary)
                        }
                    }
                    .navigationTitle("coffeeshops")
                    .searchable(text: $searchContent,placement: .navigationBarDrawer(displayMode: .always))
                }
            }
        }.overlay(
            coffeeshopInformation(showDetail: $showDetail, selectedCoffeeshop: $selectedCoffeeshop)
                        .animation(.easeInOut, value: showDetail)
        )
    }
}


#Preview {
    Homepage()
}
