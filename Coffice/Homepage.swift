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

//Contoh buat max range
@Observable
class filterModel: ObservableObject {
    var maxRange: Double
    
    init(maxRange: Double) {
        self.maxRange = maxRange
    }
}

struct Homepage: View {
    @State private var streak: Int = 0
    
    @State private var searchContent: String = ""
    @State private var showDetail: Bool = false
    @State private var selectedCoffeeshop: CoffeeShopStruct? = nil
    
    let coffeeShop : [CoffeeShopStruct] = [
        CoffeeShopStruct(name: "Starbucks",description: "lorem",distance: 127,steps: 123,calories: 123),
        CoffeeShopStruct(name: "Fore",description: "lorem",distance: 45 ,steps: 54,calories: 134),
        CoffeeShopStruct(name: "Tamper",description: "lorem",distance: 431,steps: 887,calories: 1223),
        CoffeeShopStruct(name: "Kopi Kenangan",description: "lorem",distance: 134,steps: 412,calories: 531),
        CoffeeShopStruct(name: "Dunkin Donuts",description: "lorem",distance: 486,steps: 212,calories: 431),
        CoffeeShopStruct(name: "Kenangan Signature",description: "lorem",distance: 325,steps: 78,calories: 431),
        CoffeeShopStruct(name: "Tabemori",description: "lorem",distance: 256,steps: 102,calories: 45)
    ]
    
    
    //    ["Starbucks","Fore","Tamper","Kopi Kenangan","Dunkin Donuts"]
    
    var filteredCoffeeshop: [CoffeeShopStruct] {
        guard !searchContent.isEmpty else {
            return coffeeShop
        }
        return coffeeShop
            .filter {
                $0.name.localizedCaseInsensitiveContains(searchContent)
            }
    }
    
    
    
    var body: some View {
        VStack(alignment: .leading){
            userProfile()
            Color.red
                .frame(height: 150)
            VStack{
                
                NavigationView{
                    List(filteredCoffeeshop.sorted(by: {$0.distance < $1.distance})) { shop in
                        Button(action: {
                            selectedCoffeeshop = shop
                            showDetail = true
                        }){
                            HStack{
                                Text(shop.name)
                                    .foregroundColor(.primary)
                                Spacer()
                                Text(String(shop.distance))
                                    .foregroundColor(.primary)
                            }

                        }
                        .listRowSeparator(.hidden)
                        
                    }
                    .navigationTitle("coffeeshops")
                    .searchable(text: $searchContent,placement: .navigationBarDrawer(displayMode: .always))
                }
            }
        }.overlay(
            coffeeshopInformation(showDetail: $showDetail, selectedCoffeeshop: $selectedCoffeeshop)
                .animation(.easeInOut, value: showDetail)
        )
//        sheet(isPresented: $showDetail){
//            coffeeshopInformation(showDetail: $showDetail, selectedCoffeeshop: $selectedCoffeeshop)
//                .animation(.easeInOut, value: showDetail)
//        }

    }
}


struct userProfile: View {
    var body: some View {
    VStack {
                HStack {
                    Image("avatar")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                    .padding()
                   
                    VStack (alignment: .leading) {
                        Text("User's Name")
                        Text("User's Location")
                            .foregroundColor(.secondary)
                    
                    }
                    Spacer()
                    
                    HStack {
                        Text ("25 Streak")
                        Image(systemName: "flame.fill")
                    }
                    .padding(13)
                    .background(Color.orange)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding()
                    }
                    Spacer()
                          }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                      }
                  }



#Preview {
    Homepage()
}
