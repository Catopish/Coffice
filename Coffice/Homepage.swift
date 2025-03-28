//
//  ContentView.swift
//  Coffice
//
//  Created by Hafi on 20/03/25.
//

import SwiftUI
import SwiftData
import HealthKit

struct CoffeeShopStruct: Identifiable {
    var id = UUID()
    var name: String
    var location: String
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
        CoffeeShopStruct(name: "Starbucks",location: "Lorem Ipsum", description: "lorem",distance: 127,steps: 123,calories: 123),
        CoffeeShopStruct(name: "Fore",location: "Lorem Ipsum", description: "lorem",distance: 45 ,steps: 54,calories: 134),
        CoffeeShopStruct(name: "Tamper",location: "Lorem Ipsum", description: "lorem",distance: 431,steps: 887,calories: 1223),
        CoffeeShopStruct(name: "Kopi Kenangan",location: "Lorem Ipsum", description: "lorem",distance: 134,steps: 412,calories: 531),
        CoffeeShopStruct(name: "Dunkin Donuts",location: "Lorem Ipsum", description: "lorem",distance: 486,steps: 212,calories: 431),
        CoffeeShopStruct(name: "Kenangan Signature",location: "Lorem Ipsum", description: "lorem",distance: 325,steps: 78,calories: 431),
        CoffeeShopStruct(name: "Tabemori",location: "Lorem Ipsum", description: "lorem",distance: 256,steps: 102,calories: 45)
    ]
    
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
            healthSummary()
                .frame(height: 150)
            NavigationStack{
                VStack{
                    
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
                    .navigationTitle("Coffee Shops")
                    .searchable(text: $searchContent,placement: .navigationBarDrawer(displayMode: .always))
                }
            }
        }.overlay(
            coffeeshopInformation(showDetail: $showDetail, selectedCoffeeshop: $selectedCoffeeshop)
                .animation(.easeInOut, value: showDetail)
        )
    }
}

struct healthSummary: View {
    @StateObject private var healthKitManager = HealthKitManager.shared
    @State private var isLoading = false

    
    var body: some View {
        VStack{
            HStack{
                Text("Today's steps")
                Spacer()
                Text(isLoading ? "Loading..." : "\(healthKitManager.stepCountToday)")
            }
            .padding(.horizontal)
            HStack{
                Text("Todays calories")
                Spacer()
                Text(isLoading ? "Loading..." : "\(healthKitManager.activeEnergyBurnedToday) kcal")
            }
            .padding(.horizontal)
        }.onAppear(perform: refreshSteps)
    }
    
    func refreshSteps() {
        isLoading = true
        healthKitManager.readStepCountToday()
        healthKitManager.readActiveEnergyBurnedToday()
        
        // Simulate loading completion
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            isLoading = false
        }
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
                    Text("User")
                    Text("User location")
                        .foregroundColor(.secondary)
                    
                    
                }
                Spacer()
                
                HStack{
                    Text ("25 Streak")
                    Image(systemName: "flame.fill")
                }
                .padding(10)
                .background(Color.orange)
                .foregroundColor(.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                
            }
        }
    }
}



#Preview {
    Homepage()
}
