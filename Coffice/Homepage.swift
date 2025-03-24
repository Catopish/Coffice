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
}

struct Homepage: View {
    
    @State private var searchContent: String = ""
    @State private var showDetail: Bool = false
    @State private var selectedCoffeeshop: CoffeeShopStruct? = nil
    
    let coffeeShop : [CoffeeShopStruct] = [
        CoffeeShopStruct(name: "Starbucks",description: "lorem"),
        CoffeeShopStruct(name: "Fore",description: "lorem"),
        CoffeeShopStruct(name: "Tamper",description: "lorem"),
        CoffeeShopStruct(name: "Kopi Kenangan",description: "lorem"),
        CoffeeShopStruct(name: "Dunkin Donuts",description: "lorem")
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
