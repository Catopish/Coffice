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

@Observable
class filterModel: ObservableObject {
    var maxRange: Double
    
    init(maxRange: Double) {
        self.maxRange = maxRange
    }
}

struct Homepage: View {
    @State private var streak: Int = 0
    @AppStorage("userName") var userName: String = ""
    @State var isLoading: Bool = false
    
    
    @State private var searchContent: String = ""
    @State private var showDetail: Bool = false
    @State private var selectedCoffeeshop: CoffeeShopStruct? = nil
    @State private var showOnboarding: Bool = false
    
    
    let coffeeShop : [CoffeeShopStruct] = [
        CoffeeShopStruct(name: "Starbucks",location: "Lorem Ipsum", description: "The Breeze BSD",distance: 127,steps: 123,calories: 123),
        CoffeeShopStruct(name: "Fore",location: "The Breeze BSD", description: "lorem",distance: 45 ,steps: 54,calories: 134),
        CoffeeShopStruct(name: "Tamper",location: "The Breeze BSD", description: "lorem",distance: 431,steps: 887,calories: 1223),
        CoffeeShopStruct(name: "% Arabica",location: "The Breeze BSD", description: "lorem",distance: 134,steps: 412,calories: 531),
        CoffeeShopStruct(name: "Kenangan Signature",location: "The Breeze BSD", description: "lorem",distance: 325,steps: 78,calories: 431),
        CoffeeShopStruct(name: "Tabemori",location: "Green Office Park 6", description: "lorem",distance: 256,steps: 102,calories: 45),
        CoffeeShopStruct(name: "Lawson",location: "Green Office Park 6", description: "lorem",distance: 486,steps: 212,calories: 431),
        CoffeeShopStruct(name: "36 Grams",location: "Green Office Park 1", description: "lorem",distance: 256,steps: 102,calories: 45)
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
            HealthDashboardView(isLoading: $isLoading)
            Text("Where’s your coffee taking you today?")
                .font(.headline)
                .fontWeight(.semibold)
                .padding()
                
            NavigationStack{
                VStack() {
                    List(filteredCoffeeshop.sorted(by: {$0.distance < $1.distance})) { shop in
                        Button(action: {
                            selectedCoffeeshop = shop
                            showDetail = true
                        }){
                            HStack{
                                Text(shop.name)
                                    .foregroundColor(.primary)
                                Spacer()
                                Text("\(Int(shop.distance)) m")
                                    .foregroundColor(.primary)
                                
                            }
                        }
                        .listRowSeparator(.hidden)
                    }
                    
                    .background(Color.white)
                    .scrollContentBackground(.hidden)
                    .shadow(radius: 4)
//                    .navigationTitle("Coffee Shops")
                    .searchable(text: $searchContent,placement: .navigationBarDrawer(displayMode: .always))
                    .padding(.top, -30)
                }
            }
            .padding(.top, -20)
        }.overlay(
            coffeeshopInformation(showDetail: $showDetail, selectedCoffeeshop: $selectedCoffeeshop)
                .animation(.easeInOut, value: showDetail)
        )
        .onAppear {
            if userName.isEmpty {
                showOnboarding = true
            }
        }
        .fullScreenCover(isPresented: $showOnboarding) {
            OnboardingView()
        }
    }
}

//struct ContentView: View {
//    @AppStorage("userName") var userName: String = ""
//    
//    var body: some View {
//        if userName.isEmpty {
//            OnboardingView()
//        } else {
//            Homepage()
//        }
//    }
//}

struct userProfile: View {
    @AppStorage("userName") var userName: String = ""
    @StateObject var streakManager = StreakManager()
    var body: some View {
        HStack {
            VStack (alignment: .leading) {
                Text("Hi, \(userName)!")
                    .font(.title)
                    .fontWeight(.semibold)
                Text("Let’s walk and sip! ☕️")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
            }
            .padding()
            Spacer()
            
            HStack{
                Text ("\(streakManager.streak) Streak")
                Image(systemName: "flame.fill")
            }
            
            .padding()
            .background(Color.brown2)
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .frame(width: 150, height: 20)
            .padding(.horizontal, 5)
        }
    }
}


#Preview {
    Homepage()
}
